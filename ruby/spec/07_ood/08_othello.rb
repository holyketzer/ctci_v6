class Disk
  attr_accessor :top_side # :white or :black
end

class Board
  attr_accessor :width, :height, :board

  def initialize(width, height)
    @width = width
    @height = height

    # @board[row][col]
    @board = Array.new(height)

    height.times do |row|
      board[row] = Array.new(width)
    end
  end

  def move_possible?(row, col, disk)
    board[row][col] == nil && has_line_in_any_direction?(row, col)
  end

  def move(row, col, disk)
    board[row][col] = disk
    convert_lines_in_all_directions(row, col)
  end
end

class Game
  attr_reader :board, :available_disks, :curr_move

  def initialize
    @board = Board.new(8, 8)
  end
end
