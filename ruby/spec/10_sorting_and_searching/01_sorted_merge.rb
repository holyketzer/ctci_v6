# n = a.size
# Time = O(n), Mem = O(n)
# a.size >= a_size + b.size
def sorted_merge_a(a, b, a_size)
  i = a_size + b.size - 1
  ai = a_size - 1
  bi = b.size - 1

  while i > 0 do
    if (ai >= 0 && bi >= 0 && a[ai] > b[bi]) || (ai >= 0 && bi < 0)
      a[i] = a[ai]
      ai -= 1
    else
      a[i] = b[bi]
      bi -= 1
    end

    i -= 1
  end

  a
end

RSpec.describe 'sorted_merge' do
  %i(a).each do |implementation|
    describe "#{implementation} case" do
      subject { send("sorted_merge_#{implementation}", a, b, a_size) }

      let(:a) { [1, 3, 5, 7, nil, nil, nil] }
      let(:b) { [2, 3, 4] }
      let(:a_size) { a.count { |v| v != nil } }

      it { is_expected.to eq [1, 2, 3, 3, 4, 5, 7] }
    end
  end
end
