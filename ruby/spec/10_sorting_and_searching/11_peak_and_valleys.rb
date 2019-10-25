# Time = O(n), Mem = O(1)
def peak_and_valleys_a(arr)
  (0..(arr.size - 3)).each do |i|
    peak = i % 2 == 1

    if peak
      min, mid, max = *arr[i..(i+2)].sort

      arr[i] = min
      arr[i + 1] = max
      arr[i + 2] = mid
    end
  end

  arr
end

RSpec.describe 'peak_and_valleys' do
  %i(a).each do |implementation|
    describe "#{implementation} case" do
      subject { send("peak_and_valleys_#{implementation}", arr) }

      context 'book sample' do
        let(:arr) { [5, 3, 1, 2, 3] }

        it { is_expected.to eq [5, 1, 3, 2, 3] }
      end

      context 'more complex sample' do
        let(:arr) { [7, 4, 1, 10, 9, 5, 3, 6, 8, 2] }

        it { is_expected.to eq [7, 1, 10, 4, 9, 3, 6, 2, 8, 5] }
      end
    end
  end
end
