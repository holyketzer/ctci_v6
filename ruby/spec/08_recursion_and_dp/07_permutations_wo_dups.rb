# n - str size
# Time = O(n!), Mem = O(n!)
def permutations_wo_dups(str)
  if str.size == 1
    [str]
  else
    res = []

    str.each_char.each_with_index do |c, i|
      subs = str.dup
      subs[i, 1] = '' # remove i-th char

      permutations_wo_dups(subs).each do |subres|
        res << subres + c
      end
    end

    res
  end
end

RSpec.describe 'permutations_wo_dups' do
  subject { permutations_wo_dups(str).sort }

  context '1-char str' do
    let(:str) { 'a' }

    it { is_expected.to eq ['a'] }
  end

  context '2-chars str' do
    let(:str) { 'ab' }

    it { is_expected.to eq ['ab', 'ba'] }
  end

  context '3-chars str' do
    let(:str) { 'abc' }

    it { is_expected.to eq ['abc', 'acb', 'bac', 'bca', 'cab', 'cba'] }
  end
end
