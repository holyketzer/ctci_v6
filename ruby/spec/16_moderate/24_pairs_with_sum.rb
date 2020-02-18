module PairsWithSum
  def solve(arr, sum)
    c = Hash.new { |hash, key| hash[key] = 0 }
    arr.each { |x| c[x] += 1 }

    res = []
    arr.each do |x|
      y = sum - x

      # Mistake #1 no check for x == y case
      if (x != y && c[x] > 0 && c[y] > 0) || (x == y && c[x] > 1)
        c[x] -= 1
        c[y] -= 1

        res << [x, y]
      end
    end

    res
  end

  RSpec.describe 'rand7' do
    include PairsWithSum

    subject { solve(arr, sum) }

    let(:arr) { [1, 2, 3, 4, 5, 6, 7, 8, 9, 0] }

    context 'sum = 5' do
      let(:sum) { 5 }

      it { is_expected.to eq [[1, 4], [2, 3], [5, 0]] }
    end

    context 'sum = 6' do
      let(:sum) { 6 }

      it { is_expected.to eq [[1, 5], [2, 4], [6, 0]] }
    end

    context 'sum = 1' do
      let(:sum) { 1 }

      it { is_expected.to eq [[1, 0]] }
    end

    context 'sum = 0' do
      let(:sum) { 0 }

      it { is_expected.to eq [] }
    end
  end
end
