# Time: O(a*log a + b*log b), Mem = O(1)
def smallest_difference(a, b)
  a.sort!
  b.sort!

  diff = Float::INFINITY

  ai = 0
  bi = 0

  while ai < a.size && bi < b.size do
    curr_diff = (a[ai] - b[bi]).abs

    if curr_diff < diff
      diff = curr_diff
    end

    if a[ai] < b[bi]
      ai += 1
    else
      bi += 1
    end
  end

  diff
end

RSpec.describe 'smallest_difference' do
  subject { smallest_difference(a, b) }

  context 'non zero difference' do
    let(:a) { [1, 3, 15, 11, 2] }
    let(:b) { [23, 127, 235, 19, 8] }

    it { is_expected.to eq 3 }
  end

  context 'zero difference' do
    let(:a) { [1, 3, 15, 11, 2] }
    let(:b) { [23, 127, 235, 19, 8, 11] }

    it { is_expected.to eq 0 }
  end

  context 'one array is empty' do
    let(:a) { [] }
    let(:b) { [23, 127, 235, 19, 8, 11] }

    it { is_expected.to eq Float::INFINITY }
  end
end
