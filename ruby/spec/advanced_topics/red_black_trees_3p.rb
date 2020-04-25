require 'colorize'

# Reb-black tree implementation according to Sedgewick and Wayne https://algs4.cs.princeton.edu/33balanced/
module RedBlackTrees3p
  class Node
    attr_accessor :color, :left, :right, :parent, :value

    def initialize(value, parent: nil, color: :red)
      @value = value
      @parent = parent
      @color = color
    end

    def left_child?
      parent && (parent.left == self || (parent.left == nil && self.value == nil))
    end

    def right_child?
      parent && (parent.right == self || (parent.right == nil && self.value == nil))
    end

    def to_s
      str = value.to_s
      '(' + left.to_s + (color == :black ? str : str.red) + right.to_s + ')'
    end

    def validate!
      if color == :red && (left&.color == :red || right&.color == :red)
        raise Exception, "red node #{value} has red child"
      end

      left&.validate!
      right&.validate!
    end

    def depth
      1 + [left&.depth || 0, right&.depth || 0].max
    end

    def size
      1 + (left&.size || 0) + (right&.size || 0)
    end

    def black_heights(curr = 0, path = [])
      if color == :black
        curr += 1
      end

      path << value

      if child_count == 0
        # puts "#{path} = #{curr + 1}"
        path.pop
        [curr + 1, curr + 1]
      elsif child_count == 1
        if left
          left.black_heights(curr, path).tap { path.pop } + [curr + 1]
        else
          [curr + 1] + right.black_heights(curr, path).tap { path.pop }
        end
      else
        left.black_heights(curr, path) + right.black_heights(curr, path).tap { path.pop }
      end
    end

    def child_count
      if left && right
        2
      elsif left || right
        1
      else
        0
      end
    end
  end

  class Tree
    attr_reader :root

    def add(value)
      @root = add_node(root, value)

      while root.parent
        @root = root.parent
      end

      root.color = :black
    end

    def remove(value)
      if (@root = remove_node(root, value))
        while root.parent
          @root = root.parent
        end

        root.color = :black

        if root.value == nil
          @root = nil
        end
      end
    end

    def to_s
      root&.to_s
    end

    def depth
      root&.depth || 0
    end

    def size
      root&.size || 0
    end

    def black_heights
      root&.black_heights || []
    end

    def validate!
      root&.validate!

      max_expected_depth = (2 * Math.log(size + 1, 2)).ceil

      if depth > max_expected_depth
        raise Exception, "tree is unbalanced depth=#{depth} size=#{size} max_expected_depth=#{max_expected_depth}"
      end

      bh = black_heights

      if bh.uniq.size > 1
        raise Exception, "tree violates equal black height rule for all leaves #{bh}"
      end
    end

    private

    def black?(node)
      node == nil || node.color == :black
    end

    def red?(node)
      node != nil && node.color == :red
    end

    def add_node(node, value)
      parent = nil
      origin_node = node

      while node != nil do
        parent = node

        if value < node.value
          node = node.left
        else
          node = node.right
        end
      end

      node = Node.new(value, parent: parent)

      if parent
        if value < parent.value
          parent.left = node
        else
          parent.right = node
        end
      end

      rebalance_on_add(node)
      origin_node || node
    end

    def rebalance_on_add(node)
      while red?(node.parent) do
        p = node.parent
        if p.left_child?
          u = p.parent.right

          if red?(u)
            p.color = :black
            u.color = :black
            p.parent.color = :red
            node = p.parent
          else
            if node.right_child?
              node = p
              left_rotate(node)
            end

            node.parent.color = :black
            node.parent.parent.color = :red
            right_rotate(node.parent.parent)
          end
        else
          u = p.parent.left

          if red?(u)
            p.color = :black
            u.color = :black
            p.parent.color = :red
            node = p.parent
          else
            if node.left_child?
              node = p
              right_rotate(node)
            end

            node.parent.color = :black
            node.parent.parent.color = :red
            left_rotate(node.parent.parent)
          end
        end
      end
    end

    def remove_node(node, value)
      next_node = nil
      origin_node = node

      while node != nil do
        if node.value == value
          removed_color = node.color

          if node.left == nil
            next_node = node.right || Node.new(nil, parent: node.parent, color: :black)
            move(node, node.right)
          elsif node.right == nil
            next_node = node.left || Node.new(nil, parent: node.parent, color: :black)
            move(node, node.left)
          else
            min_node = find_min_node(node.right)
            removed_color = min_node.color
            next_node = min_node.right || Node.new(nil, parent: min_node.parent, color: :black)

            if min_node.parent == node
              next_node.parent = min_node
            else
              move(min_node, min_node.right)
              min_node.right = node.right
              min_node.right.parent = min_node
            end

            move(node, min_node)
            min_node.left = node.left
            min_node.left.parent = min_node
            min_node.color = node.color
          end

          if removed_color == :black
            rebalance_on_remove(next_node)
          end

          break
        elsif value < node.value
          node = node.left
        else
          node = node.right
        end
      end

      next_node || origin_node
    end

    def rebalance_on_remove(node)
      # puts "rebalance_on_remove #{node.value}"
      while node.parent != nil && black?(node) do
        # puts "#{node.value || 'nil'} left child?=#{node.left_child?}"
        if node.left_child?
          u = node.parent.right

          if red?(u)
            u.color = :black
            node.parent.color = :red
            left_rotate(node.parent)
            u = node.parent.right
          end

          if black?(u.left) && black?(u.right)
            u.color = :red
            node = node.parent
          else
            if black?(u.right)
              u.left.color = :black
              u.color = :red
              right_rotate(u)
              u = node.parent.right
            end

            u.color = node.parent.color
            node.parent.color = :black
            u.right.color = :black
            left_rotate(node.parent)
            node = nil
            break
          end
        else
          u = node.parent.left

          if red?(u)
            u.color = :black
            node.parent.color = :red
            right_rotate(node.parent)
            u = node.parent.left
          end

          if black?(u.left) && black?(u.right)
            u.color = :red
            node = node.parent
          else
            if black?(u.left)
              u.right.color = :black
              u.color = :red
              left_rotate(u)
              u = node.parent.left
            end

            u.color = node.parent.color
            node.parent.color = :black
            u.left.color = :black
            right_rotate(node.parent)
            node = nil
            break
          end
        end
      end

      if node
        node.color = :black
      end
    end

    def find_min_node(node)
      if node.left
        find_min_node(node.left)
      else
        node
      end
    end

    def move(u, v)
      if u.parent == nil
        #
      elsif u.left_child?
        u.parent.left = v
      else
        u.parent.right = v
      end

      if v
        v.parent = u.parent
      end
    end

    def left_rotate(x)
      y = x.right
      x.right = y.left

      if y.left != nil
        y.left.parent = x
      end

      y.parent = x.parent

      if x.parent == nil
        #
      elsif x.left_child?
        x.parent.left = y
      else
        x.parent.right = y
      end

      y.left = x
      x.parent = y
      y
    end

    def right_rotate(x)
      y = x.left
      x.left = y.right

      if y.right != nil
        y.right.parent = x
      end

      y.parent = x.parent

      if x.parent == nil
        #
      elsif x.right_child?
        x.parent.right = y
      else
        x.parent.left = y
      end

      y.right = x
      x.parent = y
      y
    end
  end

  RSpec.describe 'RedBlackTrees3p' do
    include RedBlackTrees3p

    def log(value)
      if only_this_file_run?(__FILE__)
        puts value
      end
    end

    it do
      1.times do
        tree = Tree.new
        arr = []

        10.times do
          x = rand(0..100)
          tree.add(x)
          arr << x
          log(tree.to_s)
          tree.validate!
        end

        20.times do
          x = rand(100..200)
          tree.add(x)
          arr << x
          log(tree.to_s)
          tree.validate!
        end

        expect(tree.size).to eq arr.size

        arr.sort.each_with_index do |x, index|
          tree.remove(x)
          log(tree.to_s)
          expect(tree.size).to eq arr.size - index - 1
          tree.validate!
        end

        expect(tree.size).to eq 0
      end
    end
  end
end
