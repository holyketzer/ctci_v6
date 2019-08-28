# Matrix MxN

# time = O(M*N), mem = O(M + N)
def zero_matrix_a(matrix)
  res = []
  n = matrix.size # rows
  m = matrix[0].size # cols

  zero_rows = Array.new(n)
  zero_cols = Array.new(m)

  m.times do |col|
    n.times do |row|
      if matrix[row][col] == 0
        zero_rows[row] = true
        zero_cols[col] = true
      end
    end
  end

  m.times do |col|
    n.times do |row|
      if zero_rows[row] || zero_cols[col]
        matrix[row][col] = 0
      end
    end
  end

  matrix
end

RSpec.describe 'zero_matrix' do
  %i(a).each do |implementation|
    describe "#{implementation} case" do
      subject { send("zero_matrix_#{implementation}", matrix) }

      context '3x2' do
        let(:matrix) do
          [
            [1, 0, 3],
            [4, 5, 6],
          ]
        end

        let(:expected_matrix) do
          [
            [0, 0, 0],
            [4, 0, 6],
          ]
        end

        it { is_expected.to eq expected_matrix }
      end

      context '3x4' do
        let(:matrix) do
          [
            [1, 2,  3],
            [0, 6,  7],
            [9, 10, 11],
            [0, 14, 15],
          ]
        end

        let(:expected_matrix) do
          [
            [0, 2,  3],
            [0, 0,  0],
            [0, 10, 11],
            [0, 0,  0],
          ]
        end

        it { is_expected.to eq expected_matrix }
      end
    end
  end
end
