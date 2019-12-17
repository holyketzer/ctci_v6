class Point
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end
end

class Segment
  attr_reader :left, :right

  def initialize(left, right)
    if left.x < right.x
      @left = left
      @right = right
    else
      @left = right
      @right = left
    end
  end

  def vertical?
    left.x == right.x
  end

  def horizontal?
    left.y == right.y
  end

  def k_coeff
    (left.y - right.y) / (left.x - right.x)
  end

  def b_coeff
    right.y - (right.x * k_coeff)
  end

  def bottom
    [left.y, right.y].min
  end

  def top
    [left.y, right.y].max
  end

  def x_intersection(other)
    l = [left.x, other.left.x].max
    r = [right.x, other.right.x].min

    if l <= r
      l
    end
  end

  def y_intersection(other)
    b = [bottom, other.bottom].max
    t = [top, other.top].min

    if b <= t
      b
    end
  end

  def x_include?(x)
    left.x <= x && right.x >= x
  end

  def y_include?(y)
    bottom <= y && top >= y
  end
end

def intersection(s1, s2)
  if s1.vertical? && s2.vertical?
    if s1.left.x == s2.left.x && y = s1.y_intersection(s2)
      return [s1.left.x, y]
    end
  elsif s1.vertical? || s2.vertical?
    if s2.vertical?
      s1, s2 = s2, s1
    end

    x = (s1.top - s2.b_coeff) / s2.k_coeff

    if s1.x_include?(x)
      return [x, s1.top]
    end
  elsif s1.k_coeff == s2.k_coeff
    if s2.b_coeff == s1.b_coeff && x = s1.x_intersection(s2)
      y = x * s1.k_coeff + s1.b_coeff
      return [x, y]
    end
  else
    x = (s2.b_coeff - s1.b_coeff) / (s1.k_coeff - s2.k_coeff)
    y = x * s1.k_coeff + s1.b_coeff

    s1.x_include?(x) && s1.y_include?(y) && s2.x_include?(x) && s2.y_include?(y)

    return [x, y]
  end

  nil
end

RSpec.describe 'intersection' do
  subject { intersection(s1, s2) }

  context 'cross intersection' do
    let(:s1) { Segment.new(Point.new(1, 1), Point.new(3, 3)) }
    let(:s2) { Segment.new(Point.new(1, 3), Point.new(3, 1)) }

    it { is_expected.to eq [2, 2] }
  end

  context 'point touch' do
    let(:s1) { Segment.new(Point.new(1, 1), Point.new(3, 3)) }
    let(:s2) { Segment.new(Point.new(3, 3), Point.new(3, 1)) }

    it { is_expected.to eq [3, 3] }
  end

  context 'parrallel vertial segments' do
    let(:s1) { Segment.new(Point.new(1, 1), Point.new(1, 3)) }
    let(:s2) { Segment.new(Point.new(3, 1), Point.new(3, 3)) }

    it { is_expected.to eq nil }
  end

  context 'vertial seq segments' do
    let(:s1) { Segment.new(Point.new(1, 1), Point.new(1, 3)) }
    let(:s2) { Segment.new(Point.new(1, 4), Point.new(1, 5)) }

    it { is_expected.to eq nil }
  end

  context 'vertial overlapping segments' do
    let(:s1) { Segment.new(Point.new(1, 1), Point.new(1, 3)) }
    let(:s2) { Segment.new(Point.new(1, 2), Point.new(1, 5)) }

    it { is_expected.to eq [1, 2] }
  end

  context 'horizontal parrallel segments' do
    let(:s1) { Segment.new(Point.new(1, 0), Point.new(3, 0)) }
    let(:s2) { Segment.new(Point.new(2, 2), Point.new(4, 2)) }

    it { is_expected.to eq nil }
  end

  context 'horizontal seq segments' do
    let(:s1) { Segment.new(Point.new(1, 0), Point.new(3, 0)) }
    let(:s2) { Segment.new(Point.new(4, 0), Point.new(7, 0)) }

    it { is_expected.to eq nil }
  end

  context 'horizontal over segments' do
    let(:s1) { Segment.new(Point.new(1, 0), Point.new(3, 0)) }
    let(:s2) { Segment.new(Point.new(2, 0), Point.new(7, 0)) }

    it { is_expected.to eq [2, 0] }
  end

  context 'not intersecting segments' do
    let(:s1) { Segment.new(Point.new(0, 1), Point.new(2, 3)) }
    let(:s2) { Segment.new(Point.new(1, 0), Point.new(3, 2)) }

    it { is_expected.to eq nil }
  end
end
