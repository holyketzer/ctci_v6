# n - str length

# A: time = O(n), mem = O(1)
def one_way_a?(s1, s2)
  size_diff = (s1.size - s2.size).abs

  if size_diff > 1
    false
  elsif size_diff == 0
    delta = 0
    i = 0

    while i < s1.size do
      if s1[i] != s2[i]
        delta += 1
      end

      i += 1
    end

    delta == 1
  else
    long, short = s1.size > s2.size ? [s1, s2] : [s2, s1]

    s = 0
    l = 0
    delta = 0

    while s < short.size && l < long.size do
      if short[s] == long[l]
        s += 1
        l += 1
      else
        delta += 1
        l += 1
      end
    end

    delta += long.size - l

    delta == 1
  end
end

RSpec.describe 'one_way' do
  %i(a).each do |implementation|
    describe "#{implementation} case" do
      subject { send("one_way_#{implementation}?", s1, s2) }

      context 'delete in the middle' do
        let(:s1) { 'pale' }
        let(:s2) { 'ple' }

        it { is_expected.to eq true }
      end

      context 'delete first' do
        let(:s1) { 'pale' }
        let(:s2) { 'ale' }

        it { is_expected.to eq true }
      end

      context 'delete last' do
        let(:s1) { 'pale' }
        let(:s2) { 'pal' }

        it { is_expected.to eq true }
      end

      context 'insert in the begining' do
        let(:s1) { 'pale' }
        let(:s2) { 'spale' }

        it { is_expected.to eq true }
      end

      context 'insert in the middle' do
        let(:s1) { 'pale' }
        let(:s2) { 'paale' }

        it { is_expected.to eq true }
      end

      context 'insert in the end' do
        let(:s1) { 'pale' }
        let(:s2) { 'pales' }

        it { is_expected.to eq true }
      end

      context 'replace' do
        let(:s1) { 'pale' }
        let(:s2) { 'bale' }

        it { is_expected.to eq true }
      end

      context 'more than 1 step' do
        let(:s1) { 'pale' }
        let(:s2) { 'bake' }

        it { is_expected.to eq false }
      end
    end
  end
end
