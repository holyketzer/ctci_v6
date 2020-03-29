module MaxSubmatrix
  # Time=O(n^4) Mem=O(n^2) n - count of rows ~ count of cols
  def solve_a(matrix)
    cache = Hash.new { |hash, key| hash[key] = {} }

    rows_count = matrix.size
    cols_count = matrix[0].size

    each_matrix_size(rows_count, cols_count) do |max_row, max_col|
      sum = 0

      (0..max_row).each do |row|
        (0..max_col).each do |col|
          sum += matrix[row][col]
        end
      end

      cache[max_row][max_col] = sum
    end

    max = matrix[0][0]
    res = [[0, 0], [0, 0]]

    # Bruteforce
    each_matrix_size(rows_count, cols_count) do |from_row, from_col|
      max_row_count = rows_count - from_row
      max_col_count = cols_count - from_col

      each_matrix_size(max_row_count, max_col_count) do |row_offset, col_offset|
        to_row = from_row + row_offset
        to_col = from_col + col_offset

        sum = submatrix_sum(cache, from_row, from_col, to_row, to_col)

        if sum > max
          max = sum
          res = [[from_row, from_col], [to_row, to_col]]
        end
      end
    end

    res
  end

  def each_matrix_size(rows_count, cols_count, &block)
    rows_count.times do |max_row|
      cols_count.times do |max_col|
        block.call(max_row, max_col)
      end
    end
  end

  def submatrix_sum(cache, from_row, from_col, to_row, to_col)
    abcd_sum = cache[to_row][to_col]
    a_sum = from_row > 0 && from_col > 0 ? cache[from_row - 1][from_col - 1] : 0
    ba_sum = from_col > 0 ? cache[to_row][from_col - 1] : 0
    ca_sum = from_row > 0 ? cache[from_row - 1][to_col] : 0

    abcd_sum + a_sum - ca_sum - ba_sum
  end

  def solve_b(matrix)
    rows_count = matrix.size
    cols_count = matrix[0].size

    max = matrix[0][0]
    res = [[0, 0], [0, 0]]

    rows_count.times do |from_row|
      cols_sum = Array.new(cols_count) { 0 }

      (from_row..(rows_count - 1)).each do |to_row|
        cols_count.times do |col|
          cols_sum[col] += matrix[to_row][col]
        end

        sum, col_range = *max_subarray(cols_sum)

        if sum > max
          max = sum
          res = [[from_row, col_range[0]], [to_row, col_range[1]]]
        end
      end
    end

    res
  end

  def max_subarray(arr)
    max = arr[0]
    res = [0, 0]
    from = 0
    sum = 0

    arr.each_with_index do |x, index|
      sum += x

      if sum > max
        max = sum
        res = [from, index]
      elsif sum < 0
        sum = 0
        from = index + 1
      end
    end

    [max, res]
  end

  RSpec.describe 'MaxSubmatrix' do
    include MaxSubmatrix

    %i(a b).each do |implementation|
      context "implementation #{implementation}" do
        subject { send("solve_#{implementation}", matrix) }

        let(:matrix) do
          [
            [ 1,  2, -5, -2],
            [ 0, -3, -7,  5],
            [-1,  4, 10,  3],
            [ 9, -7,  8,  1],
          ]
        end

        it { is_expected.to eq [[2, 0], [3, 3]] }
      end
    end
  end
end
