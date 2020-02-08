module PatternMatching
  # Time=O(n^2) Mem=O(n)
  def match?(pattern, str)
    if pattern.empty?
      return false
    end

    a_count = pattern.count('a')
    b_count = pattern.count('b')

    if a_count + b_count < pattern.size
      raise ArgumentError, "unexpected char in pattern #{pattern}"
    end

    if b_count > a_count
      a_count, b_count = b_count, a_count
      pattern = pattern.gsub('a', 'c').gsub('b', 'a').gsub('c', 'b')
    end
    # With check before a_count always will be > 0

    a_size = 1 # Mistake 1: Messed up with a_count and a_size vars
    b_size = 1

    while a_size <= str.size && b_size >= 0 do
      b_size = b_count > 0 ? (str.size - a_size * a_count) / b_count.to_f : 0

      if (b_size - b_size.floor) == 0 && b_size >= 0
        a_sub = nil
        b_sub = nil
        offset = 0

        pattern.each_char do |c|
          # Optimized solution: it doesn't build strings then compare in with str
          # it check pattern parts step by step and break if it isn't match
          if c == 'a'
            curr_sub = str[offset, a_size]
            offset += a_size # mistake 2: it should increase offset before break

            a_sub ||= curr_sub

            if a_sub != curr_sub
              break
            end
          elsif c == 'b'
            curr_sub = str[offset, b_size]
            offset += b_size

            b_sub ||= curr_sub

            if b_sub != curr_sub
              break
            end
          end
        end

        if offset == str.size
          return true
        end
      end

      a_size += 1
    end

    false
  end

  RSpec.describe 'solve' do
    include PatternMatching

    subject { match?(pattern, str) }

    let(:str) { 'catcatgocatgo' }

    context 'empty pattern' do
      let(:pattern) { '' }

      it { is_expected.to eq false }
    end

    context 'a' do
      let(:pattern) { 'a' }

      it { is_expected.to eq true }
    end

    context 'b' do
      let(:pattern) { 'b' }

      it { is_expected.to eq true }
    end

    context 'aa' do
      let(:pattern) { 'aa' }

      it { is_expected.to eq false }
    end

    context 'bb' do
      let(:pattern) { 'bb' }

      it { is_expected.to eq false }
    end

    context 'ab' do
      let(:pattern) { 'ab' }

      it { is_expected.to eq true }
    end

    context 'aabab' do
      let(:pattern) { 'aabab' }

      it { is_expected.to eq true }
    end

    context 'aababc' do
      let(:pattern) { 'aababc' }

      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'babab' do
      let(:pattern) { 'babab' }

      it { is_expected.to eq false }
    end
  end
end
