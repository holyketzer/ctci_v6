RSpec.describe 'linked list' do
  describe '#ll' do
    subject { ll([1, 2, 3, 4, 5]) }

    it { expect(ll_to_array(subject)).to eq [1, 2, 3, 4, 5] }
  end

  describe '#ll_add_value' do
    subject { ll_add_value(list, 4) }

    let(:list) { ll([1, 2, 3]) }

    it { expect(ll_to_array(subject)).to eq [1, 2, 3, 4] }
  end

  describe '#ll_size' do
    subject { ll_size(list) }

    let(:list) { ll([1, 2, 3]) }

    it { is_expected.to eq 3 }
  end
end
