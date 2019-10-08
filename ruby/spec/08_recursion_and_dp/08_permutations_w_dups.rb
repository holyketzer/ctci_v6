def permutations_w_dups(str, sorted = false)
  if !sorted
    str = str.chars.sort.join
  end

  if str.size == 1
    [str]
  else
    res = []
    dups = {}

    str.each_char.each_with_index do |c, i|
      if !dups[c]
        subs = str.dup
        subs[i, 1] = '' # remove i-th char

        permutations_w_dups(subs, true).each do |subres|
          res << subres + c
        end

        dups[c] = true
      end
    end

    res
  end
end

RSpec.describe 'permutations_w_dups' do
  subject { permutations_w_dups(str).sort }

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

  context '3-chars str with dups' do
    let(:str) { 'aba' }

    it { is_expected.to eq ['aab', 'aba', 'baa'] }
  end

  context '4-chars str with dups' do
    let(:str) { 'abab' }

    it { is_expected.to eq ['aabb', 'abab', 'abba', 'baab', 'baba', 'bbaa'] }
  end
end
