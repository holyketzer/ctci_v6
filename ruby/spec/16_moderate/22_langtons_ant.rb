module LangstonsAnt
  class Board
    attr_reader :row_range, :col_range

    def initialize
      @board = Hash.new { |hash, key| hash[key] = {} }
      @row_range = 0..0
      @col_range = 0..0
      fill(0, 0)
    end

    def fill(row, col)
      # Chess mate field
      # @board[row][col] ||= (row - col) % 2 == 0 ? :black : :white

      # White field
      @board[row][col] ||= :white

      @row_range = [row_range.min, row].min..[row_range.max, row].max
      @col_range = [col_range.min, col].min..[col_range.max, col].max

      @board[row][col]
    end

    def get(row, col)
      @board[row][col] || fill(row, col)
    end

    def flip(row, col)
      @board[row][col] = get(row, col) == :white ? :black : :white
    end

    def to_s
      res = ''

      @row_range.each do |row|
        @col_range.each do |col|
          res << (get(row, col) == :white ? '_ ' : 'X ')
        end
        res << "\n"
      end

      res
    end

    def stats
      items_count = @board.values.reduce(0) { |s, v| s + v.size }
      field_size = row_range.size * col_range.size
      ratio = items_count / field_size.to_f
      puts "Items count: #{items_count} Field size: #{field_size} Sparce ratio: #{ratio.round(1)}"
    end
  end

  # Time=O(k) Mem=O(k)
  def print_moves(k)
    board = Board.new
    row = 0
    col = 0
    dir = [1, 0] # dx (col), dy (row)

    k.times do
      color = board.get(row, col)

      # Turn
      dir = color == :white ? turn_right(dir) : turn_left(dir)

      # Flip
      board.flip(row, col)

      # Move
      row += dir[1]
      col += dir[0]
    end

    if only_this_file_run?(__FILE__)
      board.stats
    end

    board.to_s
  end

  def turn_right(dir)
    if dir == [1, 0]
      [0, -1]
    elsif dir == [0, -1]
      [-1, 0]
    elsif dir == [-1, 0]
      [0, 1]
    elsif dir == [0, 1]
      [1, 0]
    else
      raise ArgumentError, "worng dir #{dir}"
    end
  end

  def turn_left(dir)
    if dir == [1, 0]
      [0, 1]
    elsif dir == [0, 1]
      [-1, 0]
    elsif dir == [-1, 0]
      [0, -1]
    elsif dir == [0, -1]
      [1, 0]
    else
      raise ArgumentError, "worng dir #{dir}"
    end
  end

  RSpec.describe 'print_moves' do
    include LangstonsAnt

    subject { print_moves(k) }

    let(:k) { 12000 }

    it do
      if only_this_file_run?(__FILE__)
        puts subject
      else
        subject
      end
    end
  end
end
