# n - size of arr
# Time = O(log n), worth case O(n), Mem = O(log n)
def sparse_search_a(arr, v, l = 0, r = arr.size - 1)
  m = (l + r) / 2

  while arr[m] == '' && m < r do
    m += 1
  end

  if m == r
    m = (l + r) / 2

    while arr[m] == '' && m > l do
      m -= 1
    end

    if m == l
      return nil
    end
  end

  if arr[m] == v
    return m
  elsif arr[m] > v
    r = m - 1
  else
    l = m + 1
  end

  sparse_search_a(arr, v, l, r)
end

RSpec.describe 'sparse_search' do
  %i(a).each do |implementation|
    describe "#{implementation} case" do
      subject { send("sparse_search_#{implementation}", arr, v) }

      let(:arr) { ['', 'at', '', '', '', 'ball', '', '', 'car', '', '', 'dad', '', ''] }

      context 'existing value "at"' do
        let(:v) { 'at' }

        it { is_expected.to eq 1 }
      end

      context 'existing value "dad"' do
        let(:v) { 'dad' }

        it { is_expected.to eq 11 }
      end

      context 'not existing value "her"' do
        let(:v) { 'her' }

        it { is_expected.to eq nil }
      end
    end
  end
end
