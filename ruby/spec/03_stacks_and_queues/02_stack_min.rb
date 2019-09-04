# n - stack size
# O(1) for push, pop and min methods
class StackWithMin
  class SNode
    attr_reader :value, :prev, :min

    def initialize(value, prev_min, prev = nil)
      @value = value
      @prev = prev
      @min = value < prev_min ? value : prev_min
    end
  end

  def initialize
    @tail = nil
  end

  def push(value)
    if @tail
      @tail = SNode.new(value, @tail.min, @tail)
    else
      @tail = SNode.new(value, value)
    end
  end

  def pop
    if @tail
      value = @tail.value
      @tail = @tail.prev
      value
    end
  end

  def min
    @tail&.min
  end

  def to_s
    arr = []
    curr = @tail

    while curr do
      arr << "v=#{curr.value} m=#{curr.min}"
      curr = curr.prev
    end

    '|[' + arr.reverse.map(&:to_s).join(', ') + ']'
  end
end

RSpec.describe StackWithMin do
  let(:stack) { described_class.new }

  describe 'push - min - pop' do
    it do
      stack.push(1)
      expect(stack.min).to eq 1

      stack.push(2)
      expect(stack.min).to eq 1

      stack.push(0)
      expect(stack.min).to eq 0

      stack.push(1)
      expect(stack.min).to eq 0

      expect(stack.pop).to eq 1
      expect(stack.min).to eq 0

      expect(stack.pop).to eq 0
      expect(stack.min).to eq 1

      expect(stack.pop).to eq 2
      expect(stack.min).to eq 1

      expect(stack.pop).to eq 1
      expect(stack.min).to eq nil

      expect(stack.pop).to eq nil
    end
  end
end
