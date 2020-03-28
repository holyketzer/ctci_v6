require 'rb_heap'

module MaxBlackSquare
  class HorizontalLine
    attr_reader :row, :left, :right

    def initialize(row, left, right)
      @row, @left, @right = row, left, right
    end

    def size
      @right - @left + 1
    end

    def inspect
      "(row=#{row} col=#{left}..#{right})"
    end
  end

  class VerticalLine
    attr_reader :col, :top, :bottom

    def initialize(col, top, bottom)
      @col, @top, @bottom = col, top, bottom
    end

    def size
      @bottom - @top + 1
    end

    def inspect
      "(col=#{col} row=#{top}..#{bottom})"
    end
  end

  def solve(matrix)
    # Max heap with all horizontal lines
    horizontal_lines_heap = Heap.new { |a, b| a.size > b.size }
    # All lines by row
    horizontal_lines = Hash.new { |hash, key| hash[key] = [] }
    # and column
    vertical_lines = Hash.new { |hash, key| hash[key] = [] }

    matrix.size.times do |index|
      each_row_line(matrix, index) do |from, to|
        line = HorizontalLine.new(index, from, to)
        horizontal_lines_heap << line
        horizontal_lines[index] << line
      end

      each_col_line(matrix, index) do |from, to|
        line = VerticalLine.new(index, from, to)
        vertical_lines[index] << line
      end
    end

    # puts horizontal_lines
    # puts vertical_lines

    while horizontal_lines_heap.size > 0 do
      line = horizontal_lines_heap.pop
      # puts "\nNew line #{line.inspect}"
      left = line.left
      right = line.right

      # square can be above the line
      if line.row + 1 >= line.size
        top = line.row - (line.size - 1)
        bottom = line.row

        top_line = horizontal_lines[top].find do |top_line|
          top_line.left <= left && top_line.right >= right
        end

        left_line = vertical_lines[left].find do |left_line|
          left_line.top <= top && left_line.bottom >= bottom
        end

        right_line = vertical_lines[right].find do |right_line|
          right_line.top <= top && right_line.bottom >= bottom
        end

        if top_line && left_line && right_line
          return [[left, top], [right, bottom]]
        end
      end

      # square can be below the line
      if matrix.size - line.row >= line.size
        top = line.row
        bottom = line.row + (line.size - 1)

        bottom_line = horizontal_lines[bottom].find do |bottom_line|
          bottom_line.left <= left && bottom_line.right >= right
        end

        left_line = vertical_lines[left].find do |left_line|
          left_line.top <= top && left_line.bottom >= bottom
        end

        right_line = vertical_lines[right].find do |right_line|
          right_line.top <= top && right_line.bottom >= bottom
        end

        if bottom_line && left_line && right_line
          return [[left, top], [right, bottom]]
        end
      end
    end

    nil
  end

  def all_lines_by_crosses(line_starts, &block)
    line_starts.size.times do |i|
      (i..(line_starts.size - 1)).each do |j|
        block.call(line_starts[i], line_starts[j])
      end
    end
  end

  def each_row_line(matrix, row, &block)
    line_starts = []

    matrix.size.times do |i|
      if matrix[row][i]
          # start line only if there is a cross with vertical line
        if (row > 0 && matrix[row - 1][i]) || (row < matrix.size - 2 && matrix[row + 1][i])
          line_starts << i
        end
      elsif line_starts.any?
        all_lines_by_crosses(line_starts) do |p1, p2|
          block.call(p1, p2)
        end
        line_starts = []
      end
    end

    if line_starts.any?
      all_lines_by_crosses(line_starts) do |p1, p2|
        block.call(p1, p2)
      end
    end
  end

  def each_col_line(matrix, col, &block)
    line_starts = []

    matrix.size.times do |i|
      if matrix[i][col]
        # start line only if there is a cross with horizonal line
        if (col > 0 && matrix[i][col - 1]) || (col < matrix.size - 2 && matrix[i][col + 1])
          line_starts << i
        end
      elsif line_starts.any?
        all_lines_by_crosses(line_starts) do |p1, p2|
          block.call(p1, p2)
        end

        line_starts = []
      end
    end

    if line_starts.any?
      all_lines_by_crosses(line_starts) do |p1, p2|
        block.call(p1, p2)
      end
    end
  end

  def parse_grid(lines)
    lines.map do |line|
      line.each_char.map { |c| c == 'x' }
    end
  end

  RSpec.describe 'MaxBlackSquare' do
    include MaxBlackSquare

    subject { solve(matrix) }

    context 'big whole square' do
      let(:matrix) do
        parse_grid(
          [
            '.x........',
            'xxxxxxxxx.',
            '.x...x..x.',
            'xx.x.x..x.',
            'xx...x..x.',
            '.xxxxx..x.',
            '.xxx....x.',
            '.x.xx...x.',
            '.xxxxxxxx.',
            '..........',
          ]
        )
      end

      it { is_expected.to eq [[1, 1], [8, 8]] }
    end

    context 'big whole tricky square' do
      let(:matrix) do
        parse_grid(
          [
            '.x........',
            'xxxxxxxxx.',
            '.x...x..x.',
            'xx.x.x..x.',
            'xx...x..x.',
            '.xxxxx..x.',
            '.xxx....x.',
            '.x.xx...x.',
            '.xxxxxxxxx',
            '........x.',
          ]
        )
      end

      it { is_expected.to eq [[1, 1], [8, 8]] }
    end

    context 'more tricky square' do
      let(:matrix) do
        parse_grid(
          [
            '.x.x.x...',
            'xxxxxxxxx',
            '.x.x.x.x.',
            'xxxxxx.x.',
            '.x.x.x.x.',
            'xxxxxxxx.',
            '.x.x.x.x.',
            '.........',
            '.........',
          ]
        )
      end

      it { is_expected.to eq [[1, 1], [5, 5]] }
    end

    context 'case big fragmented square' do
      let(:matrix) do
        parse_grid(
          [
            '..........',
            '.xxxxxxxx.',
            '.x...x..x.',
            'xx.x.x..x.',
            'xx...x..x.',
            '.xxxxx..x.',
            '.xxx....x.',
            '.x.xx...x.',
            '.xxxxx.xx.',
            '..........',
          ]
        )
      end

      it { is_expected.to eq [[1, 1], [5, 5]] }
    end
  end
end
