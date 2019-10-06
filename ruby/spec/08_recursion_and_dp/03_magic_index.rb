# n - size of arr
# Time = O(log(n)), Mem = O(log(n))
def magic_index(arr, from = 0, to = arr.size - 1)
  m = (to + from) / 2

  if arr[m] == m
    m
  elsif from == to
    nil
  elsif arr[m] > m
    magic_index(arr, from, m - 1)
  else
    magic_index(arr, m + 1, to)
  end
end

# Time = O(n), Mem = O(n)
def magic_index_not_distinct(arr, from = 0, to = arr.size)
  arr.each_with_index do |value, i|
    if value == i
      return i
    end
  end

  nil
end

RSpec.describe 'magic_index' do
  describe 'for distinct numbers' do
    subject { magic_index(arr) }

    context 'has magic index 1' do
      let(:arr) { [-1, 1, 3, 5, 7, 9] }

      it { is_expected.to eq 1 }
    end

    context 'has magic index 4' do
      let(:arr) { [-3, -1, 0, 1, 4, 7] }

      it { is_expected.to eq 4 }
    end

    context 'has magic index 6' do
      let(:arr) { [-3, -1, 0, 1, 2, 3, 6] }

      it { is_expected.to eq 6 }
    end

    context 'has no magic index' do
      let(:arr) { [-3, -1, 0, 1, 5, 7] }

      it { is_expected.to eq nil }
    end
  end

  context 'for not distinct numbers' do
    subject { magic_index_not_distinct(arr) }

    context 'has magic index 3' do
      let(:arr) { [2, 2, 3, 3, 3, 7] }

      it { is_expected.to eq 3 }
    end

    context 'has magic index 5' do
      let(:arr) { [-1, 0, 0, 2, 2, 5] }

      it { is_expected.to eq 5 }
    end

    context 'has magic index 5 (sc)' do
      let(:arr) { [4, 4, 4, 4, 5, 5] }

      it { is_expected.to eq 5 }
    end

    context 'no has magic index' do
      let(:arr) { [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1] }

      it { is_expected.to eq nil }
    end
  end
end
