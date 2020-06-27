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

    def include?(item)
      case item
      when Numeric
        left <= item && item <= right
      when Interval
        (left <= item.left && item.left <= self.right) || (left <= item.right && item.right <= self.right)
      else
        raise ArgumentError, "unsupported type #{item.class}"
      end
    end

    def intersect?(interval)
      self.include?(interval) || interval.include?(self)
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

  class PointIndexNode
    attr_accessor :value, :intervals, :left, :right, :parent

    def initialize(index, li = 0, ri = index.size - 1, parent = nil)
      mi = (ri + li) / 2
      @value, @intervals = *index[mi]
      @parent = parent

      @left = mi > li ? PointIndexNode.new(index, li, mi - 1, self) : nil
      @right = ri > mi ? PointIndexNode.new(index, mi + 1, ri, self) : nil
    end

    def find_min(interval)
      if interval.left == value
        self
      elsif interval.left < value && left
        left.find_min(interval)
      elsif interval.left > value && right
        right.find_min(interval)
      elsif interval.include?(value)
        self
      end
    end

    def find_max(interval)
      if interval.right == value
        self
      elsif interval.right < value && left
        left.find_max(interval)
      elsif interval.right > value && right
        right.find_max(interval)
      elsif interval.include?(value)
        self
      end
    end

    def each_up_to(max_node, &block)
      node = self

      while node do
        block.call(node)

        if node == max_node
          break
        end

        node = min_node(node.right) || parent_of_left_subtree(node)
      end
    end

    def min_node(node)
      prev = node

      while node do
        prev = node
        node = node.left
      end

      prev
    end

    def parent_of_left_subtree(node)
      while node && node.parent && node.parent.left != node do
        node = node.parent
      end

      node&.parent
    end

    def to_s
      "(#{@left} [#{value} #{intervals.map(&:to_s).join(' + ')}] #{right})"
    end

    class << self
      def build(intervals)
        index = intervals.each_with_object(Hash.new { |hash, key| hash[key] = [] }) do |interval, res|
          res[interval.left] << interval
          res[interval.right] << interval
        end

        if index.size > 0
          new(index.sort_by(&:first))
        else
          nil
        end
      end
    end
  end

  class Node
    attr_reader :center, :left, :right, :middle, :point_index

    def initialize(intervals, build_point_index = true)
      @center = median(intervals.map(&:center))

      @left, @middle, @right = *split(intervals, @center)

      if build_point_index
        @point_index = PointIndexNode.build(intervals)
      end
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
        left_intervals.any? ? Node.new(left_intervals, false) : nil,
        middle_intervals.any? ? MiddleNode.new(middle_intervals) : nil,
        right_intervals.any? ? Node.new(right_intervals, false) : nil,
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
        if point_index
          intervals = Set.new

          # Cover all intervals which intersect interval
          min_node = point_index.find_min(interval)
          max_node = point_index.find_max(interval)

          if (min_node && max_node)
            min_node.each_up_to(max_node) do |node|
              node.intervals.each do |i|
                if !intervals.include?(i)
                  intervals << i
                  yielder << i
                end
              end
            end
          end

          # Cover all intervals which enclose interval
          each_intersection_with_point(interval.center) do |i|
            if !intervals.include?(i)
              intervals << i
              yielder << i
            end
          end
        end
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
      end << Interval.new(0, 100)
    end

    let(:point) { 9 }
    let(:interval) { Interval.new(8, 10) }

    it do
      # puts intervals.sort_by(&:left)
      # puts tree.point_index.to_s

      expect(tree.each_intersection_with_point(point).map(&:to_s).sort).to eq(
        intervals.select { |i| i.include?(point) }.map(&:to_s).sort
      )

      expect(tree.each_intersection_with_interval(interval).map(&:to_s).sort).to eq (
        intervals.select { |i| i.intersect?(interval) }.map(&:to_s).sort
      )
    end
  end
end
