# CAS compareAndSet

class BiaryMaxHeap
  def initialize(arr = [])
    @arr = arr
    @heap_size = arr.size
    build_heap
  end

  def build_heap
    (@heap_size / 2 .. 0).step(-1).each do |i|
      heapify(i)
    end
  end

  def heapify(i)
    max_index = i
    max_value = @arr[i]

    left = i * 2
    right = i * 2 + 1

    if left < @heap_size && @arr[left] > max_value
      max_value = @arr[left]
      max_index = left
    end

    if right < @heap_size && @arr[right] > max_value
      max_value = @arr[right]
      max_index = right
    end

    if max_index != i
      @arr[max_index] = @arr[i]
      @arr[i] = max_value
    end

    if i > 0
      heapify(i / 2)
    end
  end
end

RSpec.describe BiaryMaxHeap do
  describe '#initialize' do
    subject { described_class.new(arr) }

    let(:arr) { [1,2,3,4,5,6,7,8,9,10].shuffle }

    it do
      p subject
    end
  end
end
