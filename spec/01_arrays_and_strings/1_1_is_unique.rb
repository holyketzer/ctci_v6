# str.size = n
# alphabet(str) = a (size of alphabet)

# A: time = O(n), mem = O(a)
def all_uniq_a?(str)
  h = {}

  str.each_char do |c|
    if h[c]
      return false
    else
      h[c] = true
    end
  end

  true
end

# C: time = O(n*log(n)), mem = O(1)
def all_uniq_c?(str)
  str = sort!(str)

  (str.size - 1).times do |i|
    if str[i] == str[i + 1]
      return false
    end
  end

  true
end

# E: time = O(n), mem = O(1)
# Special case if alphabet <= 64 (for 64 bits systems), and alphabet is continuous
def all_uniq_e?(str)
  bits = 0

  str.each_char do |c|
    bit = 2 ** (c.ord - 'a'.ord)

    if bits & bit == 1
      return false
    else
      bits |= bit
    end
  end

  true
end

RSpec.describe 'all_uniq?' do
  [:a, :c, :e].each do |implementation|
    describe "#{implementation} case" do
      subject { send("all_uniq_#{implementation}?", str) }

      context 'all uniq' do
        let(:str) { 'abcdefg' }

        it { is_expected.to eq true }
      end

      context 'not all uniq' do
        let(:str) { 'abcdefga' }

        it { is_expected.to eq false }
      end
    end
  end
end
