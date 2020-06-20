module IntervalTree
  class Interval
    attr_reader :left, :right

    def initialize(left, right)
      if left < right
        @left = left
        @right = right
      else
        @left = right
        @right = left
      end
    end

    def center
      (left + right) / 2.0
    end

    def include?(point)
      left <= point && point <= right
    end

    def on_the_left?(point)
      right < point
    end

    def on_the_right?(point)
      point < left
    end

    def to_s
      "(#{left}, #{right})"
    end
  end

  class Node
    attr_reader :center, :left, :right, :middle

    def initialize(intervals)
      @center = median(intervals.map(&:center))

      @left, @middle, @right = *split(intervals, @center)
    end

    def median(values)
      values.sort[values.size / 2]
    end

    def split(intervals, center)
      left_intervals = []
      middle_intervals = []
      right_intervals = []

      intervals.each do |interval|
        if interval.on_the_left?(center)
          left_intervals << interval
        elsif interval.on_the_right?(center)
          right_intervals << interval
        else
          middle_intervals << interval
        end
      end

      [
        left_intervals.any? ? Node.new(left_intervals) : nil,
        middle_intervals.any? ? MiddleNode.new(middle_intervals) : nil,
        right_intervals.any? ? Node.new(right_intervals) : nil,
      ]
    end

    def to_s
      "[center=#{center} middle=#{middle} left=#{left} right=#{right}]"
    end

    def each_intersection_with_point(point, yielder = nil, &block)
      wrap_to_enumerator(yielder, block) do |yielder|
        if point < center
          @middle.left_ordered.each do |interval|
            if interval.left <= point
              yielder << interval
            end
          end

          @left&.each_intersection_with_point(point, yielder)
        else
          @middle.right_ordered.each do |interval|
            if point <= interval.right
              yielder << interval
            end
          end

          @right&.each_intersection_with_point(point, yielder)
        end
      end
    end

    def each_intersection_with_interval(interval, yielder = nil, &block)
      wrap_to_enumerator(yielder, block) do |yielder|

      end
    end

    # Call nested block with yielder and return enumerator and map result if wrapper_block given
    def wrap_to_enumerator(yielder, wrapper_block, &block)
      if yielder
        block.call(yielder)
      else
        res = Enumerator.new { |y| block.call(y) }

        if wrapper_block
          res.map(&wrapper_block)
        else
          res
        end
      end
    end
  end

  class MiddleNode
    attr_reader :left_ordered, :right_ordered

    def initialize(intervals)
      @left_ordered = intervals.dup.sort_by(&:left)
      @right_ordered = intervals.dup.sort_by(&:right)
    end

    def to_s
      '<lo=' + left_ordered.map(&:to_s).join(' ') + ' ro=' + right_ordered.map(&:to_s).join(' ') + '>'
    end
  end

  RSpec.describe 'IntervalTree' do
    include IntervalTree

    let(:tree) { Node.new(intervals) }

    let(:intervals) do
      10.times.flat_map do |l|
        2.times.map do |r|
          Interval.new(l - r, l + r + 1)
        end
      end
    end

    it do
      puts intervals.sort_by(&:left)
      puts tree.to_s

      expect(tree.each_intersection_with_point(9).map(&:to_s)).to eq [
        "(6, 9)", "(8, 9)", "(7, 10)", "(8, 11)", "(9, 10)"
      ]


    end
  end
end
