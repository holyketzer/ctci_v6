class Side
  # true means edge side
  attr_reader :edge, :uid

  def initialize(edge = false)
    @uid = self.class.next_uid
    @edge = edge
  end

  def fits_with?(side)
    if side
      self == side
    else
      edge == false
    end
  end

  class << self
    def next_uid
      @next_uid ||= 0
      @next_uid += 1
    end
  end
end

class Block
  # Sides
  attr_accessor :top, :bottom, :left, :right

  def to_s_arr
    format = "%3d"

    [
      "   #{format % top.uid}  ",
      "#{format % left.uid}  #{format % right.uid}",
      "   #{format % bottom.uid}  ",
      "--------",
    ]
  end

  def to_s
    to_s_arr.join("\n")
  end

  def fits_on_right?(block)
    right.fits_with?(block.left)
  end

  def fits_on_bottom?(block)
    bottom.fits_with?(block.top)
  end
end

class JigsawPuzzle
  # blocks[row][col]
  attr_reader :blocks, :width, :height

  def initialize(width:, height:)
    @width = width
    @height = height

    @blocks = height.times.map do |row|
      width.times.map { Block.new }
    end

    height.times do |row|
      blocks[row][0].left = Side.new(true)

      (width - 1).times do |col|
        left = blocks[row][col]
        right = blocks[row][col + 1]

        left.right = right.left = Side.new
      end

      blocks[row][width - 1].right = Side.new(true)
    end

    width.times do |col|
      blocks[0][col].top = Side.new(true)

      (height - 1).times do |row|
        top = blocks[row][col]
        bottom = blocks[row + 1][col]

        top.bottom = bottom.top = Side.new
      end

      blocks[height - 1][col].bottom = Side.new(true)
    end
  end

  def blocks_count
    width * height
  end

  def shuffle
    tmp = blocks.flatten.shuffle

    height.times do |row|
      width.times do |col|
        blocks[row][col] = tmp[row * width + col]
      end
    end

    self
  end

  def solved?
    horizontally_ordered? & vertically_ordered?
  end

  def horizontally_ordered?
    height.times.all? do |row|
      (width - 1).times.all? do |col|
        left = blocks[row][col]
        right = blocks[row][col + 1]

        left.fits_on_right?(right)
      end
    end
  end

  def vertically_ordered?
    width.times.all? do |col|
      (height - 1).times.all? do |row|
        top = blocks[row][col]
        bottom = blocks[row + 1][col]

        top.fits_on_bottom?(bottom)
      end
    end
  end

  def to_s
    @height.times.map do |row|
      @width.times.reduce([[], [], [], []]) do |res, col|
        @blocks[row][col].to_s_arr.each_with_index do |item, index|
          res[index] << item
        end

        res
      end.map { |arr| arr.join('|') }.join("\n")
    end.join("\n")
  end

  def solve
    left_top = find_block { |b| b.left.edge == true && b.top.edge == true }
    swap!(from: [0, 0], to: left_top)

    (1..width-1).each do |col|
      prev = blocks[0][col - 1]
      coords = find_block { |b| prev.fits_on_right?(b) }
      swap!(from: [0, col], to: coords)
    end

    (1..height-1).each do |row|
      width.times do |col|
        prev = blocks[row - 1][col]
        coords = find_block { |b| prev.fits_on_bottom?(b) }
        swap!(from: [row, col], to: coords)
      end
    end

    self
  end

  def each_block(&block)
    height.times do |row|
      width.times do |col|
        block.call(blocks[row][col], row, col)
      end
    end
  end

  def find_block(&block)
    each_block do |b, row, col|
      if block.call(b)
        return [row, col]
      end
    end

    nil
  end

  def swap!(from:, to:)
    from_row = from[0]
    from_col = from[1]

    to_row = to[0]
    to_col = to[1]

    tmp = blocks[from_row][from_col]
    blocks[from_row][from_col] = blocks[to_row][to_col]
    blocks[to_row][to_col] = tmp
  end
end

RSpec.describe 'JigsawPuzzle' do
  let(:puzzle) { JigsawPuzzle.new(width: 10, height: 7) }

  before do
    expect(puzzle.solved?).to eq true
    puzzle.shuffle
    expect(puzzle.solved?).to eq false
  end

  it do
    puzzle.solve

    if only_this_file_run?(__FILE__)
      puts puzzle.to_s
    end

    expect(puzzle.solved?).to eq true
  end
end
