module SmallestK
  def solve(arr, k, left = 0, right = arr.size - 1, count = 0)
    l = left
    r = right

    mi = rand(l..r)
    pivot = arr[mi]

    if count > arr.size * 2
      raise RuntimeError, "looks like algorithm is wrong"
    end

    while l < r do
      while arr[l] <= pivot && l <= r && l < arr.size - 1 do
        l += 1
      end

      while arr[r] > pivot && l < r do
        r -= 1
      end

      if arr[l] > arr[r] && l < r
        swap(arr, l, r)
      end
    end


    if l == k
      arr[0, k]
    elsif left <= k && right >= k && (left..right).all? { |i| arr[i] == arr[left] }
      arr[0, k]
    elsif l < k
      solve(arr, k, l, right, count + 1)
    else
      if l == arr.size - 1
        l += 1
      end

      solve(arr, k, left, l - 1, count + 1)
    end
  end

  RSpec.describe 'SmallestK' do
    include SmallestK

    subject { solve(arr, k).sort }

    let(:arr) { 20.times.to_a.shuffle }

    context 'k = 5' do
      let(:k) { 5 }

      it { is_expected.to eq [0, 1, 2, 3, 4] }
    end

    context 'arr' do
      let(:arr) { [8, 2, 13, 6, 9, 1, 11, 14, 12, 17, 4, 5, 16, 15, 3, 0, 10, 7, 19, 18] }
      let(:k) { 5 }

      it { is_expected.to eq [0, 1, 2, 3, 4] }
    end

    context 'array of uniq numbers' do
      it do
        1000.times do
          arr = 20.times.to_a.shuffle
          expect(solve(arr, 4).sort).to eq [0, 1, 2, 3]
        end
      end
    end

    context 'array of not uniq numbers' do
      it do
        1000.times do
          arr = (10.times.to_a + 10.times.to_a).shuffle
          expect(solve(arr, 5).sort).to eq [0, 0, 1, 1, 2]
        end
      end
    end

    context 'array of not uniq numbers 2' do
      it do
        1000.times do
          arr = (5.times.to_a + 5.times.to_a + 10.times.to_a).shuffle
          expect(solve(arr, 5).sort).to eq [0, 0, 0, 1, 1]
        end
      end
    end
  end
end
