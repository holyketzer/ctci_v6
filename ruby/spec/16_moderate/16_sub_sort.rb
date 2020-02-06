module SubSort
  # Time=O(n * log n) Mem=O(n)
  def sub_sort_a(arr)
    sorted_arr = arr.sort

    n = 0
    m = arr.size - 1
    i = 0

    while arr[i] == sorted_arr[i] && i < arr.size do
      n = i + 1 # mistake #1 forgot to correct n by +1 after matching
      i += 1
    end

    i = arr.size - 1
    while arr[i] == sorted_arr[i] && i > 0 && n < m do
      m = i - 1
      i -= 1
    end

    if n > m
      n = 0
      m = 0
    end

    (n..m)
  end

  # Time=O(n) Mem=O(1)
  def sub_sort_b(arr)
    i = 0
    n = 0
    while i < arr.size - 2 && arr[i] <= arr[i + 1] do
      i += 1
      n = i + 1
    end

    if n == arr.size - 1
      return 0..0
    end

    max = arr[i]

    m = arr.size - 1
    i = m
    while i > 1 && arr[i] >= arr[i - 1] do
      i -= 1
      m = i - 1
    end
    min = arr[i]

    (n..m).each do |i|
      if arr[i] < min
        min = arr[i]
      end

      if arr[i] > max
        max = arr[i]
      end
    end

    while n > 0 && arr[n - 1] > min do
      n -= 1
    end

    while m < arr.size - 1 && arr[m + 1] < max do
      m += 1
    end

    if n > m
      n = m
    end

    n..m
  end

  # Solution from book
  def find_end_of_left_subsequence(arr)
    i = 1

    while i < arr.size do
      if arr[i] < arr[i - 1]
        return i - 1
      end

      i += 1
    end

    arr.size - 1
  end

  def find_start_of_right_subsequence(arr)
    i = arr.size - 2

    while i >= 0 do
      if arr[i] > arr[i + 1]
        return i + 1
      end

      i -= 1
    end

    0
  end

  def shrink_left(arr, min_index, start)
    comp = arr[min_index]
    i = start - 1
    while i >= 0 do
      if arr[i] <= comp
        return i + 1
      end

      i -= 1
    end

    0
  end

  def shrink_right(arr, max_index, start)
    comp = arr[max_index]
    i = start
    while i < arr.size do
      if arr[i] >= comp
        return i - 1
      end

      i += 1
    end

    arr.size - 1
  end

  def sub_sort_c(arr)
    end_left = find_end_of_left_subsequence(arr)

    if end_left >= arr.size - 1
      return 0..0
    end

    # find right subsequence
    start_right = find_start_of_right_subsequence(arr)

    max_index = end_left # max of left side
    min_index = start_right # min of right side
    i = end_left + 1

    while i < start_right do
      if arr[i] < arr[min_index]
        min_index = i
      end

      if arr[i] > arr[max_index]
        max_index = i
      end

      i += 1
    end

    # slide left until less than arr[min_index]
    left_index = shrink_left(arr, min_index, end_left)

    # slide right until greater than arr[max_index]
    right_index = shrink_right(arr, max_index, start_right)

    return left_index..right_index
  end

  RSpec.describe 'sub_sort' do
    include SubSort

    %i(a b c).each do |implementation|
      describe "#{implementation} case" do
        subject { send("sub_sort_#{implementation}", arr) }

        context 'simple case' do
          let(:arr) { [1, 2, 4, 7, 10, 11, 7, 12, 6, 7, 16, 18, 19] }

          it { is_expected.to eq 3..9 }
        end

        context 'degenerate case sorted' do
          let(:arr) { [1, 2, 3, 4, 5] }

          it { is_expected.to eq 0..0 }
        end

        context 'degenerate case inverse-sorted' do
          let(:arr) { [5, 4, 3, 2, 1] }

          it { is_expected.to eq 0..4 }
        end

        context 'additional case' do
          let(:arr) { [1, 3, 2, 5, 6, 7, 8, 9, 10] }

          it { is_expected.to eq 1..2 }
        end

        context 'chaning max case' do
          let(:arr) { [1, 20, 30, 8, 5, 7, 6, 9, 10] }

          it { is_expected.to eq 1..8 }
        end

        context 'chaning min case' do
          let(:arr) { [1, 2, 3, 8, 5, 7, 0, 9, 10] }

          it { is_expected.to eq 0..6 }
        end
      end
    end
  end
end
