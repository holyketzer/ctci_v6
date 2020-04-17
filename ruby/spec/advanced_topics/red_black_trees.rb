require 'colorize'

# Reb-black tree implementation according to Sedgewick and Wayne https://algs4.cs.princeton.edu/33balanced/
module SimpleRedBlackTrees
  class Node
    attr_accessor :color, :left, :right, :value

    def initialize(value, color: :red)
      @color = color
      @value = value
    end

    def to_s
      [
        '(',
        left.to_s,
        color == :black ? value.to_s : value.to_s.red,
        right.to_s,
        ')'
      ].join
    end

    def depth
      1 + [left&.depth || 0, right&.depth || 0].max
    end

    def size
      1 + (left&.size || 0) + (right&.size || 0)
    end
  end

  class Tree
    attr_reader :root

    def add(value)
      @root = add_node(root, value)
      root.color = :black
    end

    def remove(value)
      @root = remove_node(root, value)
    end

    def to_s
      root&.to_s
    end

    def red?(node)
      node && node.color == :red
    end

    def depth
      root&.depth || 0
    end

    def size
      root&.size || 0
    end

    def validate!
      max_expected_depth = (2 * Math.log(size + 1, 2)).ceil

      if depth > max_expected_depth
        raise Exception, "tree is unbalanced depth=#{depth} size=#{size} max_expected_depth=#{max_expected_depth}"
      end
    end

    private

    def add_node(node, value)
      if node
        if value < node.value
          node.left = add_node(node.left, value)
        else
          node.right = add_node(node.right, value)
        end

        if red?(node.right) && !red?(node.left)
          node = rotate_left(node)
        end

        if red?(node.left) && red?(node.left.left)
          node = rotate_right(node)
        end

        if red?(node.left) && red?(node.right)
          node = flip_colors(node)
        end

        node
      else
        Node.new(value)
      end
    end

    def remove_node(node, value)
      if node == nil || node.value == value
        nil
      else
        if value < node.value
          node.left = remove_node(node.left, value)
        else
          node.right = remove_node(node.right, value)
        end

        node
      end
    end

    def rotate_left(node)
      x = node.right
      node.right = x.left
      x.left = node
      x.color = node.color
      node.color = :red
      x
    end

    def rotate_right(node)
      x = node.left
      node.left = x.right
      x.right = node
      x.color = node.color
      node.color = :red
      x
    end

    def flip_colors(node)
      node.left.color = :black
      node.right.color = :black
      node.color = :red
      node
    end
  end

  RSpec.describe 'SimpleRedBlackTrees' do
    include SimpleRedBlackTrees

    it do
      1.times do
        tree = Tree.new
        arr = []

        10.times do
          p x = rand(0..100)
          tree.add(x)
          arr << x
          puts tree.to_s
          tree.validate!
        end

        20.times do
          p x = rand(-100..0)
          tree.add(x)
          arr << x
          puts tree.to_s
          tree.validate!
        end

        # expect(tree.balance.abs).to be < 2
        # expect(tree.size).to eq arr.size

        # arr.shuffle.each do |x|
        #   tree.remove(x)
        #   expect(tree.balance.abs).to be < 2
        # end

        # expect(tree.size).to eq 0
      end
    end
  end
end
