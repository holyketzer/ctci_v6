module FlipToRun
  # b - count of bits
  # Time = O(b), Mem = O(1)
  def longest_seq_a(n)
    res = 0

    64.times do |bit|
      mask = 1 << bit

      if n & mask == 0
        size = detect_longest_seq(n | mask)
        if size > res
          res = size
        end
      end
    end

    res
  end

  def detect_longest_seq(x)
    res = 0
    curr = 0

    64.times do |bit|
      mask = 1 << bit
      if x & mask > 0
        curr += 1
        if curr > res
          res = curr
        end
      else
        curr = 0
      end
    end

    res
  end

  # Time = O(b), Mem = O(1)
  def longest_seq_b(n)
    res = 0
    curr = 0
    zeros = 0

    64.times do |bit|
      if has_bit?(n, bit)
        curr += 1
      else
        if zeros == 0
          zeros = 1
          curr += 1
        else
          res = curr > res ? curr : res

          if bit > 0 && has_bit?(n, bit - 1)
            zeros = 1
            curr = 2
          else
            zeros = 0
            curr = 0
          end
        end
      end
    end

    res > curr ? res : curr
  end

  def has_bit?(n, bit)
    mask = 1 << bit
    n & mask > 0
  end

  RSpec.describe 'longest_seq' do
    include FlipToRun

    %i(a b).each do |implementation|
      describe "#{implementation} case" do
        subject { send("longest_seq_#{implementation}", n) }

        let(:n) { '11011101111'.to_i(2) }

        it { is_expected.to eq 8 }
      end
    end
  end
end
