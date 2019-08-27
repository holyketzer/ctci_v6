# Matrix N-N, n = N*N

# A: time = O(n), mem = O(n)
def rotate_a(matrix)
  res = []
  n = matrix.size

  n.times do |row|
    new_row = []

    n.times do |col|
      new_row[col] = matrix[n - col - 1][row]
    end

    res[row] = new_row
  end

  res
end

# A: time = O(n), mem = O(1)
def rotate_b(matrix)
  n = matrix.size
  half_n = n / 2
  ceil_half_n = (n / 2.0).ceil

  ceil_half_n.times do |col|
    half_n.times do |row|
      t = matrix[row][col]
      matrix[row][col] = matrix[n - col - 1][row]
      matrix[n - col - 1][row] = matrix[n - row - 1][n - col - 1]
      matrix[n - row - 1][n - col - 1] = matrix[col][n - row - 1]
      matrix[col][n - row - 1] = t
    end
  end

  matrix
end

RSpec.describe 'rotate' do
  %i(a b).each do |implementation|
    describe "#{implementation} case" do
      subject { send("rotate_#{implementation}", matrix) }

      context '3x3' do
        let(:matrix) do
          [
            [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9],
          ]
        end

        let(:expected_matrix) do
          [
            [7, 4, 1],
            [8, 5, 2],
            [9, 6, 3],
          ]
        end

        it { is_expected.to eq expected_matrix }
      end

      context '4x4' do
        let(:matrix) do
          [
            [1,  2,  3,  4],
            [5,  6,  7,  8],
            [9,  10, 11, 12],
            [13, 14, 15, 16],
          ]
        end

        let(:expected_matrix) do
          [
            [13,  9, 5, 1],
            [14, 10, 6, 2],
            [15, 11, 7, 3],
            [16, 12, 8, 4],
          ]
        end

        it { is_expected.to eq expected_matrix }
      end
    end
  end
end
