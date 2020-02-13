module SumSwap
  # Time=O(aa + bb) Mem=O(aa)
  def solve(aa, bb)
    dt = aa.sum - bb.sum

    if dt % 2.0 != 0
      return nil # no solutions for integer arrays
    end

    aset = Set.new(aa)

    bb.each do |b|
      a = dt / 2 + b

      if aset.include?(a)
        return [a, b]
      end
    end

    return nil
  end

  RSpec.describe 'solve' do
    include SumSwap

    subject { solve(aa, bb) }

    context 'case 1' do
      let(:aa) { [4, 1, 2, 1, 1, 2] }
      let(:bb) { [3, 6, 3, 3] }

      it { is_expected.to eq [1, 3] }
    end

    context 'case 1 reversed' do
      let(:aa) { [3, 6, 3, 3] }
      let(:bb) { [4, 1, 2, 1, 1, 2] }

      it { is_expected.to eq [6, 4] }
    end

    context 'no integer solution' do
      let(:aa) { [1, 2] }
      let(:bb) { [2, 2] }

      it { is_expected.to eq nil }
    end

    context 'case 2' do
      let(:aa) { [1, 2] }
      let(:bb) { [3, 4] }

      it { is_expected.to eq [1, 3] }
    end

    context 'theretical integer solution' do
      let(:aa) { [1, 2] }
      let(:bb) { [2, 11] }

      it { is_expected.to eq nil }
    end
  end
end
