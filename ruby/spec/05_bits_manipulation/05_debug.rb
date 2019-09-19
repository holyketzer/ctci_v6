# Check that number has only one leading non zero bit
def power_of_two?(n)
  (n & (n -1)) == 0
end

RSpec.describe 'power_of_two?' do
  subject { power_of_two?(n) }

  context 'one leading bit' do
    let(:n) { '10000'.to_i(2) }

    it { is_expected.to eq true }
  end

  context 'one leading bit - 1' do
    let(:n) { '1'.to_i(2) }

    it { is_expected.to eq true }
  end

  context 'several non zero bits' do
    let(:n) { '100001'.to_i(2) }

    it { is_expected.to eq false }
  end
end
