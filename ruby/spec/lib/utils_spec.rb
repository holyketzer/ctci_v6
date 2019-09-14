RSpec.describe 'utils' do
  describe 'heaps_permute' do
    subject { heaps_permute(arr) }

    let(:arr) { [1, 2, 3] }

    it do
      expect(subject.to_a).to eq [
        [1, 2, 3],
        [2, 1, 3],
        [3, 1, 2],
        [1, 3, 2],
        [2, 3, 1],
        [3, 2, 1],
      ]
    end
  end

  describe 'my_permute' do
    subject { my_permute(arr) }

    let(:arr) { [1, 2, 3] }

    it do
      expect(subject.to_a).to eq [
        [3, 2, 1],
        [2, 3, 1],
        [3, 1, 2],
        [1, 3, 2],
        [2, 1, 3],
        [1, 2, 3]
      ]
    end
  end
end
