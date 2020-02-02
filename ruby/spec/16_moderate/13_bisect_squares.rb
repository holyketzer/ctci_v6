module BisectSquares
  class Point
    attr_reader :x, :y

    def initialize(x, y)
      @x = x.to_f
      @y = y.to_f
    end

    def ==(other)
      x == other.x && y == other.y
    end

    def to_s
      "(#{x}, #{y})"
    end
  end

  class Line
    attr_reader :k, :b, :x

    def initialize(k, b, x = nil)
      @k = k.to_f
      @b = b.to_f

      # Degeneracy case, k == Float::INFINITY
      if x
        @x = x.to_f
      end
    end
  end

  class Segment
    attr_reader :p1, :p2

    # mistake #2 force ordering for all cases, but segment line can have negative angle
    def initialize(p1, p2, order: true)
      if order
        @p1 = Point.new([p1.x, p2.x].min,  [p1.y, p2.y].min)
        @p2 = Point.new([p1.x, p2.x].max,  [p1.y, p2.y].max)
      else
        @p1 = p1
        @p2 = p2
      end
    end

    def vertical?
      p1.x == p2.x
    end

    def ==(other)
      p1 == other.p1 && p2 == other.p2
    end
  end

  class Square
    attr_reader :top_right, :bottom_left

    def initialize(p1, p2)
      @bottom_left = Point.new([p1.x, p2.x].min,  [p1.y, p2.y].min)
      @top_right = Point.new([p1.x, p2.x].max,  [p1.y, p2.y].max)
    end

    def bottom_right
      Point.new(top_right.x, bottom_left.y)
    end

    def top_left
      Point.new(bottom_left.x, top_right.y)
    end

    def edges
      [
        Segment.new(bottom_left, top_left),
        Segment.new(top_left, top_right),
        Segment.new(top_right, bottom_right),
        Segment.new(bottom_right, bottom_left),
      ]
    end
  end

  # Time = O(1), Mem = O(1)
  def bisect_line(s1, s2)
    m1 = Point.new(
      (s1.top_right.x + s1.bottom_left.x) / 2.0,
      (s1.top_right.y + s1.bottom_left.y) / 2.0,
    )

    m2 = Point.new(
      (s2.top_right.x + s2.bottom_left.x) / 2.0,
      (s2.top_right.y + s2.bottom_left.y) / 2.0,
    )

    line =
      if m1.x == m2.x
        Line.new(Float::INFINITY, nil, m1.y) # mistake #1 wrong infine case
      else
        k = (m2.y - m1.y) / (m2.x - m1.x)
        b = m1.y - (k * m1.x)
        Line.new(k, b)
      end

    points = (s1.edges + s2.edges).map { |e| segment_and_line_intersection(e, line) }.compact
    to_biggest_segment(points)
  end

  def segment_and_line_intersection(segment, line)
    if segment.vertical?
      if line.k.finite?
        y = line.k * segment.p1.x + line.b
        segment.p1.y <= y && segment.p2.y >= y ? Point.new(segment.p1.x, y) : nil
      else
        nil
      end
    else
      x = line.k.finite? ? (segment.p1.y - line.b) / line.k : line.x
      segment.p1.x <= x && segment.p2.x >= x ? Point.new(x, segment.p1.y) : nil
    end
  end

  def to_biggest_segment(points)
    p1 = points.min_by(&:x)
    p2 = points.max_by(&:x)

    if p1 != p2
      Segment.new(p1, p2, order: false)
    else
      p1 = points.min_by(&:y)
      p2 = points.max_by(&:y)
      Segment.new(p1, p2, order: false)
    end
  end

  RSpec.describe 'bisect_line' do
    include BisectSquares

    subject { bisect_line(s1, s2) }

    context 'one inside another' do
      let(:s1) { Square.new(Point.new(0, 0), Point.new(3, 3)) }
      let(:s2) { Square.new(Point.new(1, 1), Point.new(2, 2)) }

      it { is_expected.to eq Segment.new(Point.new(1.5, 0), Point.new(1.5, 3)) }
    end

    context 'one symetrical above another' do
      let(:s1) { Square.new(Point.new(0, 0), Point.new(3, 3)) }
      let(:s2) { Square.new(Point.new(1, 10), Point.new(2, 11)) }

      it { is_expected.to eq Segment.new(Point.new(1.5, 0), Point.new(1.5, 11)) }
    end

    context 'one not symetrical above another' do
      let(:s1) { Square.new(Point.new(0, 0), Point.new(3, 3)) }
      let(:s2) { Square.new(Point.new(0, 4), Point.new(1, 5)) }

      it { is_expected.to eq Segment.new(Point.new(0.3333333333333333, 5), Point.new(2, 0), order: false) }
    end

    context 'one symetrical right another' do
      let(:s1) { Square.new(Point.new(0, 0), Point.new(3, 3)) }
      let(:s2) { Square.new(Point.new(10, 1), Point.new(11, 2)) }

      it { is_expected.to eq Segment.new(Point.new(0, 1.5), Point.new(11, 1.5)) }
    end

    context 'one not symetrical right another' do
      let(:s1) { Square.new(Point.new(0, 0), Point.new(3, 3)) }
      let(:s2) { Square.new(Point.new(4, 2), Point.new(5, 3)) }

      it { is_expected.to eq Segment.new(Point.new(0, 1), Point.new(5, 2.6666666666666665), order: false) }
    end
  end
end
