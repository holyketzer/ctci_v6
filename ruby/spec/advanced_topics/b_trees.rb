module BTrees
  class Node
    attr_reader :t, :arr

    def initialize(t, arr: [])
      @t = t
      @arr = arr
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

    def can_remove_one?
      keys_count >= min_keys_count + 1
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
          end

          child_node.add(key)

          if child_node.full?
            left, median_key, right = *child_node.split

            median_pos = median_key < key_at(pos) ? pos : pos + 1
            insert_key_at(median_pos, median_key)
            set_left(median_pos, left)
            set_right(median_pos, right)
          end
        end
      end
    end

    def remove(key, parent = nil, ppos = nil, root: false)
      pos = find_key_position(key)

      if key == key_at(pos)
        remove_node_key_at(pos, parent, ppos, root: root)
      elsif key < key_at(pos) && (left = get_left(pos))
        left.remove(key, self, pos)
        rebalance(parent, ppos, root: root)
      elsif (right = get_right(pos))
        right.remove(key, self, pos)
        rebalance(parent, ppos, root: root)
      end
    end

    def remove_node_key_at(pos, parent = nil, ppos = nil, root: false)
      if leaf?
        remove_key_at(pos)
      else
        left, lpath = *find_max_leaf(get_left(pos), [self])
        right, rpath = *find_min_leaf(get_right(pos), [self])

        if left.keys_count > right.keys_count
          lpos = left.keys_count - 1
          set_key_at(pos, left.key_at(lpos))
          left.remove_key_at(lpos)

          cnode = left

          while lpath.size > 0 do
            pnode = lpath.last
            cnode.rebalance(pnode, pnode == self ? pos : pnode.keys_count - 1)
            cnode = lpath.pop
          end
        else
          rpos = 0
          set_key_at(pos, right.key_at(rpos))
          right.remove_key_at(rpos)

          cnode = right

          while rpath.size > 0 do
            pnode = rpath.last
            cnode.rebalance(pnode, pnode == self ? pos : 0)
            cnode = rpath.pop
          end
        end
      end

      rebalance(parent, ppos, root: root)
    end

    def find_max_leaf(node, path = [])
      if node.leaf?
        [node, path]
      else
        find_max_leaf(node.get_right(node.keys_count - 1), path << node)
      end
    end

    def find_min_leaf(node, path = [])
      if node.leaf?
        [node, path]
      else
        find_min_leaf(node.get_left(0), path << node)
      end
    end

    def rebalance(parent, ppos, root: false)
      if keys_count < min_keys_count && root == false
        pleft = parent.get_left(ppos)
        pright = parent.get_right(ppos)

        if self == pleft
          l_sibling = nil
          r_sibling = pright
        else
          l_sibling = pleft
          r_sibling = nil
        end

        if l_sibling && l_sibling.can_remove_one?
          insert_key_at(0, parent.key_at(ppos))
          spos = l_sibling.keys_count - 1
          parent.set_key_at(ppos, l_sibling.key_at(spos))
          set_left(0, l_sibling.get_right(spos))
          l_sibling.remove_key_at(spos)
        elsif r_sibling && r_sibling.can_remove_one?
          insert_key_at(keys_count, parent.key_at(ppos))
          spos = 0
          parent.set_key_at(ppos, r_sibling.key_at(spos))
          set_right(keys_count - 1, r_sibling.get_left(spos))
          r_sibling.remove_key_at(spos, left: true)
        else
          if l_sibling
            l_sibling.merge!(parent.key_at(ppos), self)
          else
            self.merge!(parent.key_at(ppos), r_sibling)
          end

          parent.remove_key_at(ppos)
        end
      end
    end

    def merge!(median, right_sibling)
      insert_key_at(keys_count, median)
      @arr.delete_at(@arr.size - 1)
      @arr += right_sibling.arr
    end

    def find_key_position(v)
      left = 0
      right = keys_count - 1
      pos = left

      while left <= right do
        pos = (left + right) / 2

        if v == key_at(pos)
          break
        elsif v < key_at(pos)
          right = pos - 1
        else
          left = pos + 1
        end
      end

      pos
    end

    def split
      median_index = max_node_size / 2
      left = Node.new(t, arr: @arr[0..(median_index - 1)])
      median = key_at(t - 1)
      right = Node.new(t, arr: @arr[(median_index + 1)..-1])
      [left, median, right]
    end

    def leaf?
      @arr[0] == nil
    end

    def insert_key_at(pos, key)
      if pos == 0
        @arr.insert(0, key) # key
        @arr.insert(0, nil) # new left pointer
      else
        index = (2 * pos) + 1
        @arr.insert(index, nil) # new right pointer
        @arr.insert(index, key)
      end
    end

    # left=True - remove left subtree, else right
    def remove_key_at(pos, left: false)
      if left
        index = (2 * pos)
        @arr.delete_at(index) # left pointer
        @arr.delete_at(index) # key
      else
        index = (2 * pos) + 1
        @arr.delete_at(index) # key
        @arr.delete_at(index) # right pointer
      end
    end

    def key_at(pos)
      @arr[(2 * pos) + 1]
    end

    def set_key_at(pos, key)
      @arr[(2 * pos) + 1] = key
    end

    def get_left(pos)
      @arr[2 * pos]
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

    def to_a
      res = []

      @arr.each_with_index do |x, index|
        if index.even?
          if x
            res += x.to_a
          end
        else
          res << x
        end
      end

      res
    end

    def validate!(root: false)
      keys_count_range = root ? 1..(max_keys_count - 1) : min_keys_count..(max_keys_count - 1)

      if !keys_count_range.include?(keys_count)
        raise Exception, "node #{@arr} has invalid keys count #{keys_count} when valid range is #{keys_count_range} t=#{t}"
      end

      each_child do |child|
        child.validate!
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

    def remove(v)
      if @root
        @root.remove(v, root: true)

        if @root.keys_count == 0
          @root = @root.get_left(0)
        end
      end
    end

    def to_s
      if @root
        @root.to_s
      else
        '[]'
      end
    end

    def to_a
      @root&.to_a || []
    end

    def validate!
      if @root
        @root.validate!(root: true)
        heights = @root.heights

        if heights.uniq.size > 1
          raise Exception, "tree is unbalnced #{heights}"
        end

        arr = to_a
        if arr != arr.sort
          raise Exception, "tree is unordered #{arr}"
        end
      end
    end

    def size
      @root&.size || 0
    end
  end

  RSpec.describe 'BTrees' do
    include BTrees

    def log(value)
      if only_this_file_run?(__FILE__)
        puts value
      end
    end

    it do
      1.times do
        tree = Tree.new(3)

        arr = []
        10.times do
          x = rand(0..49)
          tree.add(x)
          arr << x
          log(tree.to_s)
          tree.validate!
        end

        30.times do
          x = rand(50..99)
          tree.add(x)
          arr << x
          log(tree.to_s)
          tree.validate!
        end

        log("arr = #{arr}")

        expect(tree.size).to eq arr.size

        arr.each_with_index do |x, i|
          tree.remove(x)
          log(tree.to_s)
          tree.validate!
          expect(tree.size).to eq(arr.size - i - 1)
        end

        expect(tree.size).to eq 0
      end
    end
  end
end
