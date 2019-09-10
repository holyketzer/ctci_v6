class BinaryTree
  class Node
    attr_accessor :value, :left, :right, :parent

    def initialize(value, left: nil, right: nil, parent: nil)
      @value = value
      @left = left
      @right = right
      @parent = parent
    end

    def depth
      1 + [left&.depth, right&.depth, 0].compact.max
    end

    def to_s
      res = ''

      if left
        res += '(' + left.to_s + ') '
      end

      res += value.to_s

      if right
        res += ' (' + right.to_s + ')'
      end

      res
    end
  end

  attr_accessor :root

  def initialize(root = nil)
    @root = root
  end

  def to_s
    "(#{root.to_s})"
  end

  def depth
    root&.depth
  end
end
