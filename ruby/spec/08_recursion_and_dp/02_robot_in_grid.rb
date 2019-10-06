class Cell
  attr_reader :row, :col

  def initialize(row, col)
    @row = row
    @col = col
  end

  def movable?(grid)
    if grid.size > row && grid[0].size > col
      grid[row][col]
    end
  end

  def left
    Cell.new(row, col + 1)
  end

  def down
    Cell.new(row + 1, col)
  end

  def ==(another)
    row == another.row && col == another.col
  end

  def to_s
    "#{row},#{col}"
  end
end

def find_path(from, to, grid, cache = nil)
  cache ||= Hash.new { |hash, key| hash[key] = {} }
  path = cache[from.row][from.col] || LLNode.new(from)

  if from == to
    path_to_a(path)
  else
    [from.left, from.down].each do |next_cell|
      if next_cell.movable?(grid)
        cache[next_cell.row][next_cell.col] = LLNode.new(next_cell, path)
        if (res = find_path(next_cell, to, grid, cache))
          return res
        end
      end
    end

    nil
  end
end

def path_to_a(path)
  arr = []
  curr = path

  while curr do
    arr << curr.value
    curr = curr.next_node
  end

  arr.reverse
end

def grid_to_s(grid)
  grid.map do |row|
    row.map { |cell| cell ? '_' : 'x' }.join
  end.join("\n")
end

def parse_grid(lines)
  lines.map do |line|
    line.each_char.map { |c| c == '_' }
  end
end

RSpec.describe 'find_path' do
  subject { find_path(from, to, grid)&.map(&:to_s) }

  let(:from) { Cell.new(0, 0) }
  let(:to) { Cell.new(grid.size - 1, grid[0].size - 1) }

  context 'path exist' do
    let(:grid) do
      parse_grid(
        [
          '_____',
          '__x__',
          'x__x_',
          '_x_x_',
          '___xx',
          '_____',
        ]
      )
    end

    it do
      expect(subject).to eq [
        "0,0", "0,1", "1,1", "2,1", "2,2", "3,2", "4,2", "5,2", "5,3", "5,4"
      ]
    end
  end

  context 'path not exist' do
    let(:grid) do
      parse_grid(
        [
          '_____',
          '__x__',
          'x__x_',
          '_x_x_',
          '___xx',
          '__x__',
        ]
      )
    end

    it do
      expect(subject).to eq nil
    end
  end
end
