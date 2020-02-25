module RandomSet
  # n - size of arr, Time=O(n) Mem=O(n)
  def solve(arr, m)
    arr = Set.new(arr).to_a

    if m >= arr.size
      Set.new(arr)
    elsif m > 0
      arr = shuffle(arr)
      Set.new(arr[0..(m - 1)])
    else
      raise ArgumentError, "invalid m value #{m}"
    end
  end

  def shuffle(arr)
    arr.size.times do |i|
      j = rand(i)
      tmp = arr[i]
      arr[i] = arr[j]
      arr[j] = tmp
    end

    arr
  end

  RSpec.describe 'RandomSet' do
    include RandomSet

    subject { solve(arr.dup, m) }

    let(:arr) { [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10] }

    context 'm = 20' do
      let(:m) { 20 }

      it { is_expected.to eq Set.new([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) }
    end

    context 'm = 5' do
      let(:m) { 5 }

      it { expect(subject.size).to eq 5 }
    end

    context 'm = 2' do
      let(:m) { 2 }

      it { expect(subject.size).to eq 2 }
    end

    context 'm = 0' do
      let(:m) { 0 }

      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'm = -10' do
      let(:m) { -10 }

      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end
end
