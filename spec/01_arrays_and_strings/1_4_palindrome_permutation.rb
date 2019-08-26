# n - str length, a - str alphabet size

# B: time = O(n), mem = O(a)
def palindrome_permutation_b?(str)
  h = Hash.new { |hash, key| hash[key] = 0 }

  str.each_char do |c|
    if c != ' '
      h[c] += 1
    end
  end

  odd_pairs = 0

  h.each do |_, c|
    if c % 2 > 0
      odd_pairs += 1
    end
  end

  odd_pairs <= 1
end

# C: time = O(n * lon(n)), mem = O(1)
def palindrome_permutation_c?(str)
  str = sort!(str)

  odd_pairs = 0
  last_char = str[0]
  last_char_count = 1
  i = 1

  while i < str.size do
    if str[i] == last_char
      last_char_count += 1
    else

      if last_char_count % 2 > 0 && last_char != ' '
        odd_pairs += 1
      end

      last_char = str[i]
      last_char_count = 1
    end

    i += 1
  end

  if last_char_count % 2 > 0 && last_char != ' '
    odd_pairs += 1
  end

  odd_pairs <= 1
end

RSpec.describe 'palindrome_permutation' do
  %i(b c).each do |implementation|
    describe "#{implementation} case" do
      subject { send("palindrome_permutation_#{implementation}?", str) }

      context 'palindrome permutation' do
        let(:str) { 'taco cat' }

        it { is_expected.to eq true }
      end

      context 'not a palindrome permutation' do
        let(:str) { 'taco cata' }

        it { is_expected.to eq false }
      end
    end
  end
end
