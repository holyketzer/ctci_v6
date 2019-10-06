# n - count of items in s
# Time = O(2^n), Mem = O(2^n)
def all_subsets(s)
  if s.size == 1
    [s]
  else
    s1, sr = *head_and_rest(s)
    rest_subsets = all_subsets(sr)
    [s1] + rest_subsets + rest_subsets.map { |ss| ss + s1 }
  end
end

def head_and_rest(s)
  head, *rest = *s.to_a
  [Set.new(Array(head)), Set.new(Array(rest))]
end

RSpec.describe 'all_subsets' do
  subject { all_subsets(s).map(&:to_a).map(&:sort) }

  context '1 element set' do
    let(:s) { Set.new([1]) }

    it { is_expected.to eq [[1]] }
  end

  context '2 elements set' do
    let(:s) { Set.new([1, 2]) }

    it { is_expected.to eq [[1], [2], [1, 2]] }
  end

  context '3 elements set' do
    let(:s) { Set.new([1, 2, 3]) }

    it { is_expected.to eq [[1], [2], [3], [2, 3], [1, 2], [1, 3], [1, 2, 3]] }
  end

  context '4 elements set' do
    let(:s) { Set.new([1, 2, 3, 4]) }

    it do
      is_expected.to eq(
        [
          [1], [2], [3], [4],
          [3, 4], [2, 3], [2, 4], [2, 3, 4],
          [1, 2], [1, 3], [1, 4], [1, 3, 4],
          [1, 2, 3], [1, 2, 4], [1, 2, 3, 4]
        ]
      )
    end
  end
end
