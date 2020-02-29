module MissingNumber
  # bit 0..n-1
  def get_bit(arr, i, bit)
    arr[i] & (1 << bit) > 0 ? 1 : 0
  end

  # Time=O(n * 64) Mem=O(1)
  def solve_a(arr)
    n = arr.size
    max_bit = Math.log2(n + 1).ceil

    sum = 0
    expected_sum = (n + 1).times.reduce(:+)

    arr.size.times do |i|
      max_bit.times do |bit|
        sum += (1 << bit) * get_bit(arr, i, bit)
      end
    end

    expected_sum - sum
  end

  # Time=O(n * 2) Mem=O(n)
  def solve_b(arr)
    n = arr.size
    res_bits = []

    bit = 0
    indexes = (0..(n - 1)).to_a

    while indexes.size > 0 do
      ones = []
      zeros = []

      indexes.each do |i|
        if get_bit(arr, i, bit) == 1
          ones << i
        else
          zeros << i
        end
      end

      if zeros.size <= ones.size
        indexes = zeros
        res_bits << 0
      else
        indexes = ones
        res_bits << 1
      end

      bit += 1
    end

    res_bits.each_with_index.map { |v, i| v * (1 << i) }.sum
  end

  RSpec.describe 'MissingNumber' do
    include MissingNumber

    %i(a b).each do |implementation|
      context "implementation #{implementation}" do
        let(:original_arr) { (n + 1).times.to_a.shuffle }

        context 'n = 12' do
          let(:n) { 12 }

          it do
            original_arr.sort.each do |missing_number|
              arr = original_arr.reject { |i| i == missing_number }
              expect(send("solve_#{implementation}", arr)).to eq missing_number
            end
          end
        end

        context 'n = 32' do
          let(:n) { 32 }

          it do
            original_arr.sort.each do |missing_number|
              arr = original_arr.reject { |i| i == missing_number }
              expect(send("solve_#{implementation}", arr)).to eq missing_number
            end
          end
        end
      end
    end
  end
end
