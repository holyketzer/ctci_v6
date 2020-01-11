class ColoredPoint
  attr_reader :x, :y
  attr_accessor :color

  def initialize(x:, y:, color:)
    @x = x
    @y = y
    @color = color
  end

  def north(canvas)
    if y - 1 >= 0
      canvas[y - 1][x]
    end
  end

  def south(canvas)
    if y + 1 < canvas.size
      canvas[y + 1][x]
    end
  end

  def west(canvas)
    if x - 1 >= 0
      canvas[y][x - 1]
    end
  end

  def east(canvas)
    if x + 1 < canvas[0].size
      canvas[y][x + 1]
    end
  end

  def neighbors(canvas)
    [north(canvas), east(canvas), south(canvas), west(canvas)].compact
  end

  def to_s
    "(x: #{x}, y: #{y}, color: #{color})"
  end
end

def paint_fill(canvas, point, new_color)
  old_color = point.color
  point.color = new_color
  q = [point]

  while q.any? do
    p = q.shift

    next_points_to_fill(canvas, p, old_color).each do |next_point|
      next_point.color = new_color
      q << next_point
    end
  end

  canvas
end

def next_points_to_fill(canvas, point, source_color)
  point.neighbors(canvas).select { |n| n.color == source_color }
end

def canvas_to_s(canvas)
  res = ''

  canvas.each do |row|
    row.each do |point|
      res << point.color.to_s
    end
    res << "\n"
  end

  res << "\n"
end

def parse_canvas(arr)
  arr.each_with_index.map do |line, y|
    line.each_char.each_with_index.map do |c, x|
      ColoredPoint.new(x: x, y: y, color: c.to_i)
    end
  end
end

RSpec.describe 'paint_fill' do
  subject do
    canvas_to_s(paint_fill(canvas, point, color)).tap do |res|
      if only_this_file_run?(__FILE__)
        puts res
      end
    end
  end

  let(:canvas) do
    parse_canvas(
      [
        '0000000000',
        '0000110000',
        '0000110000',
        '0111111110',
        '0000110000',
        '0000110000',
        '0000110000',
        '0000110000',
        '0000000000',
      ]
    )
  end

  describe 'fill cross' do
    let(:point) { canvas[1][4] }
    let(:color) { 7 }

    it do
      expect(subject.each_char.count { |c| c == '7' }).to eq 20
      expect(subject.each_char.count { |c| c == '0' }).to eq (10 * 9 - 20)
    end
  end

  describe 'fill area' do
    let(:point) { canvas[0][0] }
    let(:color) { 7 }

    it do
      expect(subject.each_char.count { |c| c == '7' }).to eq (10 * 9 - 20)
      expect(subject.each_char.count { |c| c == '1' }).to eq 20
    end
  end
end
