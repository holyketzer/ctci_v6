# size of string = n

# B: time = O(n), mem = O(n)
def permutation_b?(s1, s2)
  if s1.size != s2.size
    return false
  end

  h1 = Hash.new { |hash, key| hash[key] = 0 }
  h2 = Hash.new { |hash, key| hash[key] = 0 }

  s1.each_char { |c| h1[c] += 1 }
  s2.each_char { |c| h2[c] += 1 }

  h1.each do |k, v|
    if h2[k] != v
      return false
    end
  end

  true
end

# C: time = O(n*lon(n)), mem = O(1)
def permutation_c?(s1, s2)
  if s1.size != s2.size
    return false
  end

  sort!(s1) == sort!(s2)
end

RSpec.describe 'permutation?' do
  [:b, :c].each do |implementation|
    describe "#{implementation} case" do
      subject { send("permutation_#{implementation}?", s1, s2) }

      context 'permutation' do
        let(:s1) { 'abcdefg' }
        let(:s2) { 'fbcgdea' }

        it { is_expected.to eq true }
      end

      context 'not permutation' do
        let(:s1) { 'fbcdefg' }
        let(:s2) { 'fbcgdea' }

        it { is_expected.to eq false }
      end

      context 'not permutation different size' do
        let(:s1) { 'fbcgde' }
        let(:s2) { 'fbcgdea' }

        it { is_expected.to eq false }
      end
    end
  end
end
