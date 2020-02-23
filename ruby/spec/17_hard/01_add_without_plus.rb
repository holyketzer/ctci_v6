module AddWithoutPlus
  WORD_SIZE_BITS = 0.size * 8

  # n - size of words in bits Time=O(n^2) Mem=O(1)
  def add_a(x, y)
    sum = x | y
    carries = x & y

    (0..(WORD_SIZE_BITS - 1)).each do |bit|
      if carries & (1 << bit) > 0
        (bit..(WORD_SIZE_BITS - 1)).each do |bit_to_invert|
          stop = sum & (1 << bit_to_invert) == 0
          sum = (sum ^ (1 << bit_to_invert)) | (sum & ~(1 << bit_to_invert))

          if stop
            break
          end
        end
      end
    end

    sum
  end

  # n - max size of x and y in bits Time=O(n^2) Mem=O(1)
  def add_b(x, y)
    while y != 0 do
      sum = x ^ y
      carries = (x & y) << 1

      x = sum
      y = carries
    end

    sum
  end

  RSpec.describe 'AddWithoutPlus' do
    include AddWithoutPlus

    %i(a b).each do |implementation|
      context "implementation #{implementation}" do
        let(:implementation) { implementation }

        it do
          def add(x, y)
            send("add_#{implementation}", x, y)
          end

          expect(add(1, 1)).to eq 2
          expect(add(10, 20)).to eq 30
          expect(add(11, 25)).to eq 36
          expect(add(0, 999)).to eq 999

          expect(add(-333, 123)).to eq(-210)
          expect(add(-7, -5)).to eq(-12)
        end
      end
    end
  end
end
