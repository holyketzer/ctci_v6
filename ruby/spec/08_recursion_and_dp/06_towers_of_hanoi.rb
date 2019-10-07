# Time, Mem = O(2^n)
def hanoi_move(from:, to:, buffer:, n: from.size)
  if n > 0
    hanoi_move(from: from, to: buffer, buffer: to, n: n - 1)
    to << from.pop
    hanoi_move(from: buffer, to: to, buffer: from, n: n - 1)
  end

  to
end

RSpec.describe 'hanoi_move' do
  subject { hanoi_move(from: from, to: to, buffer: buffer) }

  let(:to) { [] }
  let(:buffer) { [] }

  context '4 disks' do
    let(:from) { [4, 3, 2, 1] }

    it do
      is_expected.to eq [4, 3, 2, 1]

      expect(from).to eq []
      expect(buffer).to eq []
      expect(to).to eq [4, 3, 2, 1]
    end
  end

  context '7 disks' do
    let(:from) { [7, 6, 5, 4, 3, 2, 1] }

    it do
      is_expected.to eq [7, 6, 5, 4, 3, 2, 1]

      expect(from).to eq []
      expect(buffer).to eq []
      expect(to).to eq [7, 6, 5, 4, 3, 2, 1]
    end
  end
end
