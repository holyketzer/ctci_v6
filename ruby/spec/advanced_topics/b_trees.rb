module BTrees
  class Node
    attr_reader :t

    def initialize(t, arr: [])
      @t = t
      @arr = arr
      @children_count = 0

      each_child { @children_count += 1 }
    end

    def min_keys_count
      t - 1
    end

    def max_keys_count
      (2 * t) - 1
    end

    def max_node_size
      (2 * max_keys_count) + 1
    end

    def full?
      max_node_size == @arr.size
    end

    def keys_count
      if @arr.size == 0
        0
      else
        (@arr.size - 1) / 2
      end
    end

    def add(key)
      if keys_count == 0
        @arr = [nil, key, nil]
      else
        pos = find_key_position(key)
        left = key < key_at(pos)

        if leaf?
          insert_key_at(left ? pos : pos + 1, key)
        else
          child_node = (left ? get_left(pos) : get_right(pos))

          if child_node == nil
            child_node = Node.new(t)
            @children_count += 1
          end

          child_node.add(key)

          if child_node.full?
            left, median_key, right = *child_node.split

            median_pos = median_key < key_at(pos) ? pos : pos + 1
            insert_key_at(median_pos, median_key)
            set_left(median_pos, left)
            set_right(median_pos, right)
            @children_count += 1
          end
        end
      end
    end

    def find_key_position(v)
      left = 0
      right = keys_count - 1
      pos = left

      while left <= right do
        pos = (left + right) / 2

        if v < key_at(pos)
          right = pos - 1
        else
          left = pos + 1
        end
      end

      pos
    end

    def split
      # p @arr
      median_index = max_node_size / 2
      left = Node.new(t, arr: @arr[0..(median_index - 1)])
      median = key_at(t - 1)
      right = Node.new(t, arr: @arr[(median_index + 1)..-1])
      [left, median, right]
    end

    def leaf?
      @children_count == 0
    end

    def insert_key_at(pos, key)
      index = (2 * pos) + 1
      @arr.insert(index, nil) # new pointer
      @arr.insert(index, key)
    end

    def get_left(pos)
      @arr[2 * pos]
    end

    def key_at(pos)
      @arr[(2 * pos) + 1]
    end

    def get_right(pos)
      @arr[(2 * pos) + 2]
    end

    def set_left(pos, subtree)
      @arr[2 * pos] = subtree
    end

    def set_right(pos, subtree)
      @arr[(2 * pos) + 2] = subtree
    end

    def each_child(&block)
      @arr.each_with_index do |x, index|
        if index.even? && x
          block.call(x)
        end
      end
    end

    def to_s
      res = []

      @arr.each do |x|
        res << (x ? x.to_s : '*')
      end

      '[' + res.join(', ') + ']'
    end

    def size
      res = keys_count
      each_child { |child| res += child.size }
      res
    end

    def heights(parent_height = 0)
      if leaf?
        [parent_height + 1]
      else
        res = []
        each_child { |child| res << child.heights(parent_height + 1) }
        res.flatten
      end
    end

    def validate!(root: false)
      keys_count_range = root ? 1..(max_keys_count - 1) : min_keys_count..(max_keys_count - 1)

      if !keys_count_range.include?(keys_count)
        raise Exception, "node #{@arr} has invalid keys count #{keys_count} when valid range is #{keys_count_range} t=#{t}"
      end

      actual_children_count = 0

      each_child do |child|
        actual_children_count += 1
        child.validate!
      end

      if actual_children_count != @children_count
        raise Exception, "node #{@arr} has wrong child count=#{@children_count} actual child count=#{actual_children_count}"
      end
    end
  end

  class Tree
    attr_reader :t

    def initialize(t)
      @t = t
    end

    def add(v)
      @root ||= Node.new(t)
      @root.add(v)

      if @root.full?
        @root = Node.new(t, arr: @root.split)
      end
    end

    def to_s
      if @root
        @root.to_s
      else
        '[]'
      end
    end

    def validate!
      if @root
        @root.validate!(root: true)
        heights = @root.heights

        if heights.uniq.size > 1
          raise Exception, "tree is unbalnced #{heights}"
        end
      end
    end

    def size
      @root&.size || 0
    end
  end

  RSpec.describe 'BTrees' do
    include BTrees

    it do
      1.times do
        tree = Tree.new(3)
        arr = []

        10.times do
          p x = rand(0..49)
          tree.add(x)
          arr << x
          puts tree.to_s
          tree.validate!
        end

        20.times do
          p x = rand(50..99)
          tree.add(x)
          arr << x
          puts tree.to_s
          tree.validate!
        end

        # expect(tree.balance.abs).to be < 2
        expect(tree.size).to eq arr.size

        # arr.shuffle.each do |x|
        #   tree.remove(x)
        #   expect(tree.balance.abs).to be < 2
        # end

        # expect(tree.size).to eq 0
      end
    end
  end
end
