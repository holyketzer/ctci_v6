module MajorityElement
  # Time=O(n) Mem=O(1)
  def solve_a(arr)
    median_index ||= arr.size.odd? ? arr.size / 2 : (arr.size / 2) - 1
    m = nth_in_sorted(arr, median_index)
    arr.count { |x| x == m } >= (arr.size / 2 + 1) ? m : -1
  end

  def nth_in_sorted(arr, target_index, left = 0, right = arr.size - 1)
    if left >= right
      return arr[target_index]
    end

    pivot = arr[(right + left) / 2]

    l = left
    r = right

    while l < r do
      while arr[l] <= pivot && l < r do
        l += 1
      end

      while arr[r] > pivot && l < r do
        r -= 1
      end

      if arr[l] > arr[r]
        swap(arr, l, r)
      end
    end

    if (left <= target_index && target_index < l)
      nth_in_sorted(arr, target_index, left, l - 1)
    else
      nth_in_sorted(arr, target_index, r + 1, right)
    end
  end

  def swap(arr, i, j)
    tmp = arr[i]
    arr[i] = arr[j]
    arr[j] = tmp
  end

  # Time=O(n) Mem=O(1) book solution
  def solve_b(arr)
    res = arr[0]
    count = 0

    arr.each do |x|
      if count == 0
        res = x
      end

      if x == res
        count += 1
      else
        count -= 1
      end
    end

    arr.count { |x| x == res } >= (arr.size / 2 + 1) ? res : -1
  end

  RSpec.describe 'MajorityElement' do
    include MajorityElement

    %i(a b).each do |implementation|
      context "implementation #{implementation}" do
        subject { send("solve_#{implementation}", arr) }

        context 'book example' do
          let(:arr) { [1, 2, 5, 9, 5, 9, 5, 5, 5] }

          it { is_expected.to eq 5 }
        end

        context 'my example' do
          let(:arr) { [3, 2, 5, 7, 1, 2, 7, 0, 4, 5] }

          it { is_expected.to eq(-1) }
        end

        context 'edge case no' do
          let(:arr) { [1, 1, 2, 3, 1, 1, 4, 5] }

          it { is_expected.to eq(-1) }
        end

        context 'edge case yes' do
          let(:arr) { [1, 1, 2, 3, 1, 1, 4, 5, 1] }

          it { is_expected.to eq 1 }
        end

        context 'empty array' do
          let(:arr) { [] }

          it { is_expected.to eq(-1) }
        end

        context '1-item array' do
          let(:arr) { [7] }

          it { is_expected.to eq 7 }
        end

        context '2-items array' do
          let(:arr) { [7, 9] }

          it { is_expected.to eq(-1) }
        end

        context '3-items array' do
          let(:arr) { [9, 7, 9] }

          it { is_expected.to eq 9 }
        end
      end
    end
  end
end
