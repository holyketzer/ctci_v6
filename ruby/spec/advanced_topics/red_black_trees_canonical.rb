require 'colorize'

module RedBlackTrees
  class Node
    attr_accessor :color, :left, :right, :value

    def initialize(value, color: :red)
      @color = color
      @value = value
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
      root.color = :black
    end

    def remove(value)
      if (@root = remove_node(root, value)[0])
        root.color = :black
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

    def add_node_o(node, value)
      if node
        if value < node.value
          node.left = add_node(node.left, value)
        else
          node.right = add_node(node.right, value)
        end

        insert_rebalance(node)
      else
        Node.new(value)
      end
    end

    def add_node(node, value, path = [])
      if node
        path << node

        if value < node.value
          node.left = add_node(node.left, value, path)
        else
          node.right = add_node(node.right, value, path)
        end

        # Trigger rebalance when we are on granparent level
        if path.size > 2 && path[-3] == node
          gpn = path[-3..-1]

          # Replace current node if it was changed during rotation
          top_node, step_up = shorter_insert_rebalance(*gpn)
          path[-3] = top_node

          if step_up
            step_up.times { path.pop }
          else
            path.clear
          end

          top_node
        else
          node
        end
      else
        Node.new(value).tap { |n| path << n }
      end
    end

    # Challenge here do not use parent pointer in node,
    # returns: new top_node (new g) and count of step up to apply rebalance, if nil then rebalancing id done
    def shorter_insert_rebalance(g, p, n)
      if red?(p)
        if p == g.left
          u = g.right

          if red?(u)
            p.color = :black
            u.color = :black
            g.color = :red
            [g, 2]
          else
            step_up = nil

            if n == p.right
              g.left = rotate_left(p)
              p, n = n, p
              step_up = 1
            end

            p.color = :black
            g.color = :red
            [rotate_right(g), step_up]
          end
        else
          u = g.left

          if red?(u)
            p.color = :black
            u.color = :black
            g.color = :red
            [g, 2]
          else
            step_up = nil

            if n == p.left
              g.right = rotate_right(p)
              p, n = n, p
              step_up = 1
            end

            p.color = :black
            g.color = :red
            [rotate_left(g), step_up]
          end
        end
      else
        g
      end
    end

    def remove_node(node, value)
      if node
        if value == node.value
          case node.child_count
          when 0
            [nil, node.color]
          when 1
            [(node.left || node.right), node.color] #.tap { |n| n.color = :red }
          when 2
            right_min_node = find_min_node(node.right)
            node.value = right_min_node.value
            node.right, _ = *remove_node(node.right, right_min_node.value)
            [node, nil] #.tap { |n| n.color = :red }
          end
        else
          if value < node.value
            node.left, removed_color = *remove_node(node.left, value)
          else
            node.right, removed_color = *remove_node(node.right, value)
          end

          if removed_color == :black
            node.color = :red
          end

          # if remo

          [insert_rebalance(node), nil]
        end
      end
    end

    def find_min_node(node)
      if node.left
        find_min_node(node.left)
      else
        node
      end
    end

    def black?(node)
      node == nil || node.color == :black
    end

    def red?(node)
      node != nil && node.color == :red
    end

    def rotate_left(a)
      b = a.right
      a.right = b.left
      b.left = a
      b
    end

    def rotate_right(a)
      b = a.left
      a.left = b.right
      b.right = a
      b
    end

    def insert_rebalance(node, removing: false)
      g = node

      if black?(g) && red?(g.left) && red?(g.right)
        p = node.left
        u = node.right

        # Recolor
        if red?(p.left) || red?(p.right) || red?(u.left) || red?(u.right)
          p.color = :black
          u.color = :black
          node.color = :red
        end

        g
      elsif black?(g) && red?(g.left)
        p = node.left
        u = node.right

        if red?(p.left)
          p.color = :black
          g.color = :red

          rotate_right(g)
        elsif red?(p.right)
          n = p.right

          n.color = :black
          g.color = :red

          g.left = rotate_left(p)
          rotate_right(g)
        else
          g
        end
      elsif black?(g) && red?(g.right)
        p = node.right
        u = node.left

        if red?(p.right)
          p.color = :black
          g.color = :red

          rotate_left(g)
        elsif red?(p.left)
          n = p.left

          n.color = :black
          g.color = :red

          g.right = rotate_right(p)
          rotate_left(g)
        else
          g
        end
      else
        g
      end
    end
  end

  RSpec.describe 'RedBlackTrees' do
    include RedBlackTrees

    it do
      1000.times do
        tree = Tree.new
        arr = []

        10.times do
          p x = rand(0..100)
          tree.add(x)
          arr << x
          puts tree.to_s
          tree.validate!
        end

        30.times do
          p x = rand(100..200)
          tree.add(x)
          arr << x
          puts tree.to_s
          tree.validate!
        end

        # [0, 0, 3, 6, 4, 8, 8, 1, 6, 4, 18, 16, 18, 12, 14, 13, 17, 14, 18, 11].each do |x|
        #   p x
        #   tree.add(x)
        #   arr << x
        #   puts tree.to_s
        #   tree.validate!
        # end

        expect(tree.size).to eq arr.size

        # arr.sort.each_with_index do |x, index|
        #   p x
        #   tree.remove(x)
        #   puts tree.to_s
        #   expect(tree.size).to eq arr.size - index - 1
        #   tree.validate!
        # end

        # expect(tree.size).to eq 0
      end
    end
  end
end
