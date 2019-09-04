class DoubleStackQueue
  def initialize
    @in = Stack.new
    @out = Stack.new
  end

  def push(value)
    while (x = @out.pop) do
      @in.push(x)
    end

    @in.push(value)
  end

  def pop
    while (x = @in.pop) do
      @out.push(x)
    end

    @out.pop
  end

  def to_s
    arr_out = []
    curr = @out.tail

    while curr do
      arr_out << curr.value
      curr = curr.prev
    end

    arr_in = []
    curr = @in.tail
    while curr do
      arr_in << curr.value
      curr = curr.prev
    end

    '[<' + (arr_out + arr_in.reverse).map(&:to_s).join(', ') + '<]'
  end
end

RSpec.describe DoubleStackQueue do
  let(:queue) { described_class.new }

  describe 'push - pop' do
    it do
      queue.push(1)
      queue.push(2)
      queue.push(3)

      expect(queue.pop).to eq 1
      expect(queue.pop).to eq 2
      expect(queue.pop).to eq 3
      expect(queue.pop).to eq nil

      queue.push(4)
      queue.push(5)
      queue.push(6)
      expect(queue.pop).to eq 4

      queue.push(7)
      expect(queue.pop).to eq 5
      expect(queue.pop).to eq 6
      expect(queue.pop).to eq 7
      expect(queue.pop).to eq nil
    end
  end
end
