module BestLine
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
    attr_reader :k, :b

    def initialize(k, b)
      # In Degeneracy case when k == Float::INFINITY then b == x
      @k = k.to_f
      @b = b.to_f
    end

    def ==(other)
      k == other.k && b == other.b
    end
  end

  def best_line(points)
    res = Hash.new { |h, k| h[k] = Hash.new { |h2, k2| h2[k2] = 0 } }

    (0..(points.size - 1)).each do |i|
      ((i + 1)..(points.size - 1)).each do |j|
        k, b = *get_line_coeff(points[i], points[j])
        res[k][b] += 1
      end
    end

    find_best_line(res)
  end

  def find_best_line(res)
    res_k = res.keys.first
    res_b = res[res_k].keys.first
    res_count = res[res_k][res_b]

    res.each do |k, sub_res|
      sub_res.each do |b, count|
        if count > res_count
          res_count = count
          res_k = k
          res_b = b
        end
      end
    end

    if only_this_file_run?(__FILE__)
      if res_k.finite?
        puts "y = #{res_k} * x + #{res_b}"
      else
        puts "x = #{res_b}"
      end

      puts "Count of point pairs = #{res_count}, number of points = #{fac_revert(res_count) + 1}"
    end

    Line.new(res_k, res_b)
  end

  def get_line_coeff(p1, p2)
    if p1.x == p2.x
      [Float::INFINITY, p1.x]
    else
      k = (p1.y - p2.y) / (p1.x - p2.x) # Issue #1 float point accuracy, need epsilon
      b = p1.y - k * p1.x
      [k, b]
    end
  end

  def fac_revert(n)
    res = 0
    step = 1

    while n > 0 do
      n -= step
      step += step + 1
      res += 1
    end

    res
  end

  RSpec.describe 'best_line' do
    include BestLine

    subject { best_line(points) }

    context 'horizontal line' do
      let(:points) do
        [
          Point.new(1, 1),
          Point.new(2, 3),
          Point.new(3, 1),
          Point.new(4, 2),
          Point.new(5, 1),
          Point.new(7, 4),
          Point.new(8, 1),
        ]
      end

      it { is_expected.to eq Line.new(0, 1) }
    end

    context 'vertical line' do
      let(:points) do
        [
          Point.new(1, 0),
          Point.new(3, 1),
          Point.new(1, 2),
          Point.new(2, 3),
          Point.new(1, 3),
        ]
      end

      it { is_expected.to eq Line.new(Float::INFINITY, 1) }
    end
  end
end
