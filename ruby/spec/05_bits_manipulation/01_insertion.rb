# b - count of bits
# Time = O(1), Mem = O(1)
def bit_insert(n, m, i, j)
  clear_mask = (~0) << (j + 1)
  clear_mask ||= (~((~0) << i))

  v = n & clear_mask
  v | (m << i)
end

RSpec.describe 'bit_insert' do
  subject { bit_insert(n, m, i, j) }

  let(:n) { '10000000000'.to_i(2) }
  let(:m) { '10011'.to_i(2) }
  let(:i) { 2 }
  let(:j) { 6 }


  it { is_expected.to eq '10001001100'.to_i(2) }
end
