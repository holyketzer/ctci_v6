LEFT_MASK  = '1010101010101010101010101010101010101010101010101010101010101010'.to_i(2)
RIGHT_MASK = '0101010101010101010101010101010101010101010101010101010101010101'.to_i(2)

# Time = O(1), Mem = O(1)
def bit_swap_b(x)
  left = (x & LEFT_MASK) >> 1
  right = (x & RIGHT_MASK) << 1
  left | right
end

RSpec.describe 'bit swap' do
  %i(b).each do |implementation|
    describe "#{implementation} case" do
      describe 'bit_swap' do
        subject { send("bit_swap_#{implementation}", x).to_s(2) }

        context 'simple case with even bits' do
          let(:x) { '110010'.to_i(2) }

          it { is_expected.to eq '110001' }
        end

        context 'more complex case with odd bits' do
          let(:x) { '111001001'.to_i(2) }

          it { is_expected.to eq '1011000110' }
        end
      end
    end
  end
end
