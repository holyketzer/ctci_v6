require 'rb_heap'

module ContinuousMedian
  class MedianKeeper
    # Time=O(n * log n)
    def initialize(arr = [])
      @first_heap = Heap.new(:>) # max heap = first half of array
      @second_heap = Heap.new(:<) # min heap = second half of array

      arr.each { |x| add(x) }
    end

    # Time=O(1)
    def median
      @first_heap.peak
    end

    # Time=O(log n)
    def add(x)
      if @first_heap.size == 0
        @first_heap << x
      else
        # Size of te first heap always should be equal on one item more than second
        if x < @first_heap.peak
          # add new item to first heap
          @first_heap << x

          if @first_heap.size > @second_heap.size + 1
            prev = @first_heap.pop
            @second_heap << prev
          end
        else
          # add new item to second heap
          @second_heap << x

          if @second_heap.size > @first_heap.size
            prev = @second_heap.pop
            @first_heap << prev
          end
        end
      end
    end
  end

  RSpec.describe 'ContinuousMedian' do
    include ContinuousMedian

    let(:keeper) { MedianKeeper.new(arr) }

    context 'empty initial array' do
      let(:arr) { [] }

      it do
        expect(keeper.median).to eq nil

        keeper.add(5)
        expect(keeper.median).to eq 5

        keeper.add(3)
        expect(keeper.median).to eq 3

        keeper.add(4)
        expect(keeper.median).to eq 4

        keeper.add(1)
        expect(keeper.median).to eq 3

        keeper.add(0)
        expect(keeper.median).to eq 3

        keeper.add(0)
        expect(keeper.median).to eq 1

        keeper.add(9)
        expect(keeper.median).to eq 3

        keeper.add(10)
        expect(keeper.median).to eq 3

        keeper.add(5)
        expect(keeper.median).to eq 4

        keeper.add(5)
        expect(keeper.median).to eq 4

        keeper.add(5)
        expect(keeper.median).to eq 5
      end
    end

    context 'even size initial array' do
      let(:arr) { [1, 2, 3, 4] }

      it do
        expect(keeper.median).to eq 2

        keeper.add(5)
        expect(keeper.median).to eq 3

        keeper.add(1)
        expect(keeper.median).to eq 2

        keeper.add(10)
        expect(keeper.median).to eq 3

        keeper.add(10)
        expect(keeper.median).to eq 3

        keeper.add(10)
        expect(keeper.median).to eq 4
      end
    end

    context 'odd size initial array' do
      let(:arr) { [1, 2, 3, 4, 5] }

      it do
        expect(keeper.median).to eq 3

        keeper.add(5)
        expect(keeper.median).to eq 3

        keeper.add(1)
        expect(keeper.median).to eq 3

        keeper.add(10)
        expect(keeper.median).to eq 3

        keeper.add(10)
        expect(keeper.median).to eq 4

        keeper.add(10)
        expect(keeper.median).to eq 4

        keeper.add(10)
        expect(keeper.median).to eq 5
      end
    end
  end
end
