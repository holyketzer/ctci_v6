# AVL = Георгий Адельсон-Вельский + Евгений Ландис
module AvlTrees
  class AvlNode
    attr_accessor :value, :left, :right, :left_height, :right_height

    def initialize(value, left: nil, right: nil)
      @value = value

      @left_height = 0
      @right_height = 0
    end

    def balance
      left_height - right_height
    end

    def max_height
      [left_height, right_height].max
    end

    def update_heights
      @left_height = left ? left.max_height + 1 : 0
      @right_height = right ? right.max_height + 1 : 0
    end

    def balance_subtrees
      update_heights

      if balance == 2
        if left.left_height > left.right_height
          # Left left shape
          rotate_right(self)
        else
          # Left right shape
          self.left = rotate_left(self.left)
          rotate_right(self)
        end
      elsif balance == -2
        if right.right_height > right.left_height
          # Right right shape
          rotate_left(self)
        else
          # Right left shape
          self.right = rotate_right(self.right)
          rotate_left(self)
        end
      else
        self
      end
    end

    def rotate_left(node)
      new_top = node.right
      node.right = new_top.left
      new_top.left = node

      node.update_heights
      new_top.update_heights

      new_top
    end

    def rotate_right(node)
      new_top = node.left
      node.left = new_top.right
      new_top.right = node

      node.update_heights
      new_top.update_heights

      new_top
    end

    def to_s
      res = ''

      if left
        res << left.to_s + ' '
      end

      res << "#{value}"

      if right
        res << ' ' + right.to_s
      end

      '(' + res + ')'
    end

    def size
      1 + (left&.size || 0) + (right&.size || 0)
    end
  end

  class AvlTree
    attr_reader :root

    def add(value)
      @root = add_node(root, value)
    end

    def balance
      root&.balance || 0
    end

    def remove(value)
      @root = remove_node(root, value)
    end

    def to_s
      root.to_s
    end

    def size
      root&.size || 0
    end

    private

    def add_node(node, value)
      if node
        if value < node.value
          node.left = add_node(node.left, value)
        else
          node.right = add_node(node.right, value)
        end

        node.balance_subtrees
      else
        AvlNode.new(value)
      end
    end

    def remove_node(node, value)
      if node
        if value == node.value
          if node.right == nil
            node.left
          else
            l = node.left
            r = node.right
            rmin_node = find_min(r)
            rmin_node.right = delete_min_node(r)
            rmin_node.left = l
            rmin_node.balance_subtrees
          end
        else
          if value < node.value
            node.left = remove_node(node.left, value)
          else
            node.right = remove_node(node.right, value)
          end

          node.balance_subtrees
        end
      else
        nil
      end
    end

    def find_min(node)
      node.left ? find_min(node.left) : node
    end

    def delete_min_node(node)
      if node.left
        node.left = delete_min_node(node.left)
        node.balance_subtrees
      else
        node.right
      end
    end
  end

  RSpec.describe 'AvlTrees' do
    include AvlTrees

    it do
      1.times do
        tree = AvlTree.new
        arr = []

        10.times do
          x = rand(0..100)
          tree.add(x)
          arr << x
        end

        20.times do
          x = rand(-100..0)
          tree.add(x)
          arr << x
        end

        expect(tree.balance.abs).to be < 2
        expect(tree.size).to eq arr.size

        arr.shuffle.each do |x|
          tree.remove(x)
          expect(tree.balance.abs).to be < 2
        end

        expect(tree.size).to eq 0
      end
    end
  end
end
