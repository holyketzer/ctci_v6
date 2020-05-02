require 'rb_heap'

module AStar
  class Cell
    attr_reader :row, :col, :passable

    def initialize(row, col, passable)
      @row = row
      @col = col
      @passable = passable
    end

    def passable?
      @passable
    end

    def neighbour?(cell)
      dy = (row - cell.row).abs
      dx = (col - cell.col).abs

      dx >= 0 && dx <= 1 && dy >= 0 && dy <= 1
    end

    def to_s
      "(#{row}, #{col})"
    end
  end

  class Matrix
    DIRECT_STEP_COST = 1
    DIAGONAL_STEP_COST = 1.4

    def initialize(arr)
      @arr = arr
    end

    def get_cell(row, col)
      @arr[row][col] || (raise ArgumentException, "row=#{row} col=#{col} are out of range")
    end

    def rows_count
      @arr.size
    end

    def cols_count
      @arr[0].size
    end

    def each_next_step(from, visited)
      {
        [-1,  0] => DIRECT_STEP_COST,
        [ 1,  0] => DIRECT_STEP_COST,
        [ 0, -1] => DIRECT_STEP_COST,
        [ 0,  1] => DIRECT_STEP_COST,
        [-1, -1] => DIAGONAL_STEP_COST,
        [ 1,  1] => DIAGONAL_STEP_COST,
        [-1,  1] => DIAGONAL_STEP_COST,
        [ 1, -1] => DIAGONAL_STEP_COST,
      }.each do |(dr, dc), cost|
        row = from.row + dr
        col = from.col + dc

        if row >= 0 && row <= rows_count - 1 && col >= 0 && col <= cols_count - 1
          cell = get_cell(row, col)
          if cell.passable? && !visited.include?(cell)
            yield(cell, cost)
          end
        end
      end
    end

    def each_cell
      rows_count.times do |row|
        cols_count.times do |col|
          yield(get_cell(row, col))
        end
      end
    end

    def neighbour_step_cost(from, to)
      dx = (from.col - to.col).abs
      dy = (from.row - to.row).abs

      if dx == 1 && dy == 1
        DIAGONAL_STEP_COST
      else
        DIRECT_STEP_COST
      end
    end

    def to_s
      @arr.map { |row| "|#{row.map { |cell| cell.passable? ? ' ' : 'X' }.join}|" }.join("\n")
    end

    def render_path(path)
      render = Array.new(rows_count) { |i| Array.new(cols_count) }

      each_cell do |cell|
        render[cell.row][cell.col] = cell.passable? ? ' ' : 'X'
      end

      path.each do |cell|
        render[cell.row][cell.col] = '*'
      end

      render.map { |row| "|#{row.join}|" }.join("\n")
    end

    def validate_path!(path, from, to, cost)
      if path.first != from
        raise Exception, "Invalid start cell #{path.first} != #{from}"
      end

      if path.last != to
        raise Exception, "Invalid finish cell #{path.last} != #{to}"
      end

      prev = from
      actual_cost = 0

      (1..(path.size - 1)).each do |i|
        cell = path[i]

        if !prev.neighbour?(cell)
          raise Exception, "Invalid path cell #{cell} it's not neighbour for #{prev}"
        end

        if !cell.passable?
          raise Exception, "Invalid path cell #{cell} it's not passable"
        end

        actual_cost += neighbour_step_cost(prev, cell)
        prev = cell
      end

      if cost != actual_cost
        raise Exception, "Invalid path cost #{cost} actual cost = #{actual_cost}"
      end
    end
  end

  class Step
    attr_reader :to, :cost_left
    attr_accessor :actual_cost, :from

    # to - last step from target to this cell
    # actual_cost - path cost from cell to this cell
    # cost_left - min forecast cost to target from this cell
    # from - prev step
    def initialize(to, actual_cost, cost_left, from = nil)
      @to = to
      @actual_cost = actual_cost
      @cost_left = cost_left
      @from = from
    end

    def cost
      actual_cost + cost_left
    end
  end

  def solve(matrix, from, to)
    queue = Heap.new { |a, b| a.cost < b.cost }
    # queue_cache = Set.new
    queue << Step.new(from, 0, forecast_cost(from, to))

    visited = Set.new
    curr_step = nil

    while queue.size > 0 do
      curr_step = queue.pop
      curr_cell = curr_step.to
      actual_cost = curr_step.actual_cost

      if curr_cell == to
        return [actual_cost, build_path(curr_step)]
      else
        matrix.each_next_step(curr_cell, visited) do |next_cell, dcost|
          queue << Step.new(next_cell, actual_cost + dcost, forecast_cost(next_cell, to), curr_step)
        end
      end

      visited << curr_cell
    end

    nil
  end

  def build_path(curr_step)
    res = []
    prev = curr_step

    while prev do
      res << prev.to
      prev = prev.from
    end

    res.reverse
  end

  def forecast_cost(from, to)
    dx = from.col - to.col
    dy = from.row - to.row

    Math.sqrt((dx * dx) + (dy * dy))
  end

  # true - passable cell
  # false - impassable cell
  # move in horizontal or vertical directions cost 1
  # move in diagonal directions cost 1.4
  def parse_matrix(str)
    Matrix.new(
      str.split("\n").each_with_index.map do |line, row|
        line.each_char.each_with_index.map { |c, col| Cell.new(row, col, c == '.') }
      end
    )
  end

  RSpec.describe 'AStar' do
    include AStar

    subject { solve(matrix, from, to) }

    let(:matrix) do
      parse_matrix(
        <<~TEXT
          ..X..X.....X...
          .....X..X..X...
          ..X..X..X..X...
          ..X..X..X..X...
          ..X..X..X......
          ..X.....X..X...
          ..X..X.....X...
        TEXT
      )
    end

    let(:from) { matrix.get_cell(6, 0) }
    let(:to) { matrix.get_cell(0, 14) }

    it do
      cost = subject[0]
      path = subject[1]

      expect(cost).to eq 23.4

      expect(path.map(&:to_s)).to eq(
        [
          "(6, 0)", "(5, 0)", "(4, 0)", "(3, 0)", "(2, 1)", "(1, 2)", "(2, 3)", "(3, 4)",
          "(4, 4)", "(5, 5)", "(5, 6)", "(6, 7)", "(6, 8)", "(5, 9)", "(4, 10)", "(4, 11)",
          "(3, 12)", "(2, 13)", "(1, 14)", "(0, 14)"
        ]
      )

      log("Maze:")
      log(matrix.to_s)
      log("\nPath:")
      log(matrix.render_path(path))

      matrix.validate_path!(path, from, to, cost)
    end

    def log(value)
      if only_this_file_run?(__FILE__)
        puts value
      end
    end
  end
end
