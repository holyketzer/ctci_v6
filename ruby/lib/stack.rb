class Stack
  class SNode
    attr_reader :value, :prev

    def initialize(value, prev = nil)
      @value = value
      @prev = prev
    end
  end

  attr_reader :tail

  def initialize(arr = nil)
    @tail = nil

    Array(arr).reverse.each do |value|
      push(value)
    end
  end

  def push(value)
    if @tail
      @tail = SNode.new(value, @tail)
    else
      @tail = SNode.new(value)
    end

    self
  end

  def pop
    if @tail
      value = @tail.value
      @tail = @tail.prev
      value
    end
  end

  def empty?
    @tail == nil
  end

  def peek
    @tail&.value
  end

  def to_a
    res = []
    curr = @tail

    while curr do
      res << curr.value
      curr = curr.prev
    end

    res.reverse
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
