module ShorterSeqSize
  class Finder
    def initialize(arr)
      @index = 10.times.map { |i| [i, []] }.to_h

      arr.each_with_index do |d, i|
        @index[d] << i
      end
    end

    # n - arr size, a = 10 (count of digits), s - sub size 0..10 can treated as const
    # Time=O(n * log n) Mem=O(n)
    def find(sub)
      entries = sub.map { |x| @index[x] }

      if entries.any?(&:empty?)
        return nil
      end

      current = []
      rest = []

      entries.each_with_index do |entry, sub_digit_offset|
        current << entry[0]
        entry[1..-1].each { |x| rest << [x, sub_digit_offset] }
      end

      rest.sort_by!(&:first)

      min = current.min
      max = current.max
      best = max - min
      best_res = [min, max]

      rest.each do |index, sub_digit_offset|
        current[sub_digit_offset] = index

        min = current.min
        max = current.max

        if max - min < best
          best = max - min
          best_res = [min, max]
        end
      end

      best_res
    end
  end

  RSpec.describe 'ShorterSeqSize' do
    include ShorterSeqSize

    let(:finder) { Finder.new(arr) }
    let(:arr) { [7, 5, 9, 0, 2, 1, 3, 5, 7, 9, 1, 1, 5, 8, 8, 9, 7] }

    subject { finder.find(sub) }

    context 'for [1, 5, 9]' do
      let(:sub) { [1, 5, 9] }

      it { is_expected.to eq [7, 10] }
    end

    context 'for [1, 4, 9]' do
      let(:sub) { [1, 4, 9] }

      it { is_expected.to eq nil }
    end

    context 'for [7, 8, 9]' do
      let(:sub) { [7, 8, 9] }

      it { is_expected.to eq [14, 16] }
    end
  end
end
