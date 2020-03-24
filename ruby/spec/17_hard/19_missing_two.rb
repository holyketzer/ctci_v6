module MissingTwo
  def solve_for_one(arr)
    expected_sum = arr.size + 1
    sum = 0

    arr.each_with_index do |x, i|
      expected_sum += (i + 1)
      sum += x
    end

    expected_sum - sum
  end

  def solve_for_two(arr)
    expected_sum = (arr.size + 1) + (arr.size + 2)
    # It's going to be a very large number but Ruby handles it automatically
    expected_mul = (arr.size + 1) * (arr.size + 2)
    sum = 0
    mul = 1

    arr.each_with_index do |x, i|
      expected_sum += (i + 1)
      expected_mul *= (i + 1)
      sum += x
      mul *= x
    end

    x = sum_of_missing_couple = expected_sum - sum
    y = mul_of_missing_couple = expected_mul / mul

    # a and b - missing numbers
    # x = a + b
    # a = x - b

    # Solve quadratic equation
    # y = a * b
    # y = (x - b) * b
    # y = x*b - b^2
    # b^2 - x*b + y = 0
    d = (x * x) - (4 * y)

    [(x + Math.sqrt(d)) / 2, (x - Math.sqrt(d)) / 2].map(&:to_i).sort!
  end

  RSpec.describe 'MissingTwo' do
    include MissingTwo

    describe 'solve_for_one' do
      subject { solve_for_one(arr) }

      context 'missing 1' do
        let(:arr) { [2, 3, 4, 5, 6, 7, 8, 9].shuffle }

        it { is_expected.to eq 1 }
      end

      context 'missing 3' do
        let(:arr) { [1, 2, 4, 5, 6, 7, 8, 9].shuffle }

        it { is_expected.to eq 3 }
      end

      context 'missing 9' do
        let(:arr) { [1, 2, 3, 4, 5, 6, 7, 8].shuffle }

        it { is_expected.to eq 9 }
      end
    end

    describe 'solve_for_two' do
      subject { solve_for_two(arr) }

      context 'missing 1 and 2' do
        let(:arr) { [3, 4, 5, 6, 7, 8, 9].shuffle }

        it { is_expected.to eq [1, 2] }
      end

      context 'missing 8 and 9' do
        let(:arr) { [1, 2, 3, 4, 5, 6, 7].shuffle }

        it { is_expected.to eq [8, 9] }
      end

      context 'missing 3 and 8' do
        let(:arr) { [1, 2, 4, 5, 6, 7, 9].shuffle }

        it { is_expected.to eq [3, 8] }
      end
    end
  end
end
