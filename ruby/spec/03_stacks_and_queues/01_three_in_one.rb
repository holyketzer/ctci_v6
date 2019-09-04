# n - one stack size
class NStacksArray
  class StackOverflowError < StandardError
    def initialize(stack)
      super("Stack ##{stack} is overflown")
    end
  end

  attr_reader :stack_size, :stacks_count

  def initialize(stack_size:, stacks_count:)
    @stack_size = stack_size
    @arr = Array.new(stacks_count * stack_size)

    # Indexes of head and tail of stack
    @heads = Array.new(stacks_count)
    @tails = Array.new(stacks_count)

    stacks_count.times do |i|
      @heads[i] = @tails[i] = i * stack_size
    end
  end

  def size(stack)
    si = stack - 1
    @tails[si] - @heads[si]
  end

  def push(stack, value)
    if size(stack) < stack_size
      si = stack - 1
      index = (@tails[si] += 1)
      @arr[index] = value
    else
      raise StackOverflowError.new(stack)
    end
  end

  def pop(stack)
    if size(stack) > 0
      si = stack - 1
      i = @tails[si]
      @tails[si] -= 1
      @arr[i]
    end
  end

  def peek(stack)
    if size(stack) > 0
      @arr[stack - 1]
    end
  end
end

RSpec.describe NStacksArray do
  let(:stack) { described_class.new(stack_size: 5, stacks_count: 3) }

  describe 'push - pop' do
    it do
      stack.push(1, 11)

      stack.push(2, 12)
      stack.push(2, 13)

      stack.push(3, 14)
      stack.push(3, 15)
      stack.push(3, 16)

      expect(stack.pop(1)).to eq 11
      expect(stack.pop(1)).to eq nil

      expect(stack.pop(2)).to eq 13
      expect(stack.pop(2)).to eq 12
      expect(stack.pop(2)).to eq nil

      expect(stack.pop(3)).to eq 16
      expect(stack.pop(3)).to eq 15
      expect(stack.pop(3)).to eq 14
      expect(stack.pop(3)).to eq nil
    end
  end

  describe 'size overflow' do
    it do
      5.times { |i| stack.push(1, i) }
      expect(stack.size(1)).to eq 5

      expect { stack.push(1, 6) }.to raise_error(described_class::StackOverflowError)
    end
  end
end
