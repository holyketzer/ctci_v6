module ContiguosSequence
  def solve_b(arr)
    best = arr[0]
    sum = 0

    arr.each do |x|
      sum += x

      if sum > best
        best = sum
      end

      if sum < 0
        sum = 0
      end
    end

    best
  end

  # Solution from the book (looks like it doesn't work)
  def solve_c(arr)
    maxsum = 0
    sum = 0

    arr.size.times do |i|
      sum += arr[i]

      if maxsum < sum
        maxsum = sum
      elsif sum < 0
        sum = 0
      end
    end

    maxsum
  end

  RSpec.describe 'solve' do
    include ContiguosSequence

    %i(b).each do |implementation|
      describe "#{implementation} case" do
        subject { send("solve_#{implementation}", arr) }

        context 'book sample' do
          let(:arr) { [2, -8, 3, -2, 4, -10] }

          it { is_expected.to eq 5 }
        end

        context 'my sample' do
          let(:arr) { [1, -1, 2, -1, 3, -4, 5, 6, -7] }

          it { is_expected.to eq 11 }
        end

        context 'empty array' do
          let(:arr) { [] }

          it { is_expected.to eq nil }
        end

        context 'array with only negative numbers' do
          let(:arr) { [-3, -2, -1] }

          it { is_expected.to eq(-1) }
        end

        context 'array with only positive numbers' do
          let(:arr) { [1, 2, 3] }

          it { is_expected.to eq 6 }
        end
      end
    end
  end
end
