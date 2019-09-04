class SetOfStacks
  def initialize(height)
    @height = height
    @stacks = []
    @stacks_count = 0
    @sizes = {}
  end

  def push(value)
    if @stacks_count == 0
      add_stack
    end

    s = @stacks_count - 1
    pos = @sizes[s]

    @stacks[s][pos] = value

    if (@sizes[s] += 1) == @height
      add_stack
    end

    self
  end

  def compact_stack
    while @stacks_count > 0 && @sizes[@stacks_count - 1] < 1 do
      @stacks[@stacks_count - 1] = nil
      @stacks_count -= 1
    end
  end

  def pop
    compact_stack

    if @stacks_count > 0
      s = @stacks_count - 1
      pos = @sizes[s] - 1
      value = @stacks[s][pos]
      @stacks[s][pos] = nil
      @sizes[s] -= 1

      value
    end
  end

  def pop_at(s)
    if s < @stacks_count
      if (pos = @sizes[s] - 1) >= 0
        value = @stacks[s][pos]
        @stacks[s][pos] = nil
        @sizes[s] -= 1
        value
      end
    end
  end

  def to_s
    @stacks.map do |stack|
      if stack
        '[' + stack.map(&:to_s).join(', ') + ']'
      else
        'nil'
      end
    end.join("\n")
  end

  private

  def add_stack
    @sizes[@stacks_count] = 0
    @stacks[@stacks_count] = Array.new(@height)
    @stacks_count += 1
  end
end

RSpec.describe SetOfStacks do
  let(:stack) { described_class.new(3) }

  describe 'push - pop' do
    it do
      10.times do |i|
        stack.push(i)
      end

      9.downto(0) do |i|
        expect(stack.pop).to eq i
      end

      expect(stack.pop).to eq nil
    end
  end

  describe 'push - pop - push - pop' do
    it do
      3.times do |i|
        stack.push(i)
      end

      expect(stack.pop).to eq 2

      stack.push(3)
      stack.push(4)

      expect(stack.pop).to eq 4

      stack.push(5)

      expect(stack.pop).to eq 5
      expect(stack.pop).to eq 3
      expect(stack.pop).to eq 1
      expect(stack.pop).to eq 0
    end
  end

  describe 'push - pop_at' do
    it do
      10.times do |i|
        stack.push(i)
      end

      expect(stack.pop_at(2)).to eq 8
      expect(stack.pop_at(2)).to eq 7
      expect(stack.pop_at(2)).to eq 6
      expect(stack.pop_at(2)).to eq nil

      expect(stack.pop_at(0)).to eq 2
      expect(stack.pop_at(0)).to eq 1

      expect(stack.pop).to eq 9
      expect(stack.pop).to eq 5
      expect(stack.pop).to eq 4
      expect(stack.pop).to eq 3
      expect(stack.pop).to eq 0

      # Here clean stack here again

      10.times do |i|
        stack.push(i)
      end

      expect(stack.pop_at(3)).to eq 9
      expect(stack.pop_at(3)).to eq nil

      expect(stack.pop_at(1)).to eq 5
      expect(stack.pop_at(1)).to eq 4

      stack.push(20)
      stack.push(30)

      expect(stack.pop).to eq 30
      expect(stack.pop).to eq 20
    end
  end
end
