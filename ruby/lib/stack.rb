class Stack
  class SNode
    attr_reader :value, :prev

    def initialize(value, prev = nil)
      @value = value
      @prev = prev
    end
  end

  attr_reader :tail

  def initialize
    @tail = nil
  end

  def push(value)
    if @tail
      @tail = SNode.new(value, @tail)
    else
      @tail = SNode.new(value)
    end
  end

  def pop
    if @tail
      value = @tail.value
      @tail = @tail.prev
      value
    end
  end

  def to_s
    arr = []
    curr = @tail

    while curr do
      arr << curr.value
      curr = curr.prev
    end

    '|[' + arr.reverse.map(&:to_s).join(', ') + ']'
  end
end
