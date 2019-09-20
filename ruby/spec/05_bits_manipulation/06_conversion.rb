def count_of_diff_bits_a(a, b)
  res = 0

  64.times do |bit|
    if has_bit?(a, bit) != has_bit?(b, bit)
      res += 1
    end
  end

  res
end

def count_of_diff_bits_b(a, b)
  c = a ^ b
  res = 0

  64.times do |bit|
    if has_bit?(c, bit)
      res += 1
    end
  end

  res
end

def has_bit?(n, bit)
  mask = 1 << bit
  n & mask > 0
end

RSpec.describe 'conversion' do
  %i(a b).each do |implementation|
    describe "#{implementation} case" do
      describe 'count_of_diff_bits' do
        subject { send("count_of_diff_bits_#{implementation}", a, b) }

        context 'same bit size' do
          let(:a) { '110101'.to_i(2) }
          let(:b) { '100111'.to_i(2) }

          it { is_expected.to eq 2 }
        end

        context 'different bit size' do
          let(:a) { '10010101'.to_i(2) }
          let(:b) {   '100111'.to_i(2) }

          it { is_expected.to eq 4 }
        end
      end
    end
  end
end
