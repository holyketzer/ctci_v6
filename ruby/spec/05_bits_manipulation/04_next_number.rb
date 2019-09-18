# b - count of bits
# Time = O(2^b), Mem = O(1)
def next_smallest_a(n)
  if n == 0
    raise ArgumentError, 'no solution'
  end

  count = bits_count(n)
  res = n + 1

  while bits_count(res) != count && res < (1 << 64) do
    res += 1
  end

  if res < (1 << 64)
    res
  else
    raise ArgumentError, 'no solution'
  end
end

# Time = O(2^b), Mem = O(1)
def prev_biggest_a(n)
  count = bits_count(n)
  res = n - 1

  while bits_count(res) != count && res > 0 do
    res -= 1
  end

  if res > 0
    res
  else
    raise ArgumentError, 'no solution'
  end
end

def bits_count(n)
  res = 0

  64.times do |bit|
    if has_bit?(n, bit)
      res += 1
    end
  end

  res
end

def has_bit?(n, bit)
  mask = 1 << bit
  n & mask > 0
end

# 1110 not => 0001 add bit => 0011 not => 1100
# 1100

# Time = O(b), Mem = O(1)
def next_smallest_b(n)
  63.times do |i|
    if has_bit?(n, i) && !has_bit?(n, i + 1)
      return remove_bit(add_bit(n, i + 1), i)
    end
  end

  raise ArgumentError, 'no solution'
end

# Time = O(b), Mem = O(1)
def prev_biggest_b(n)
  first_bit = false
  63.downto(1) do |i|
    if first_bit
      if has_bit?(n, i) && !has_bit?(n, i - 1)
        return remove_bit(add_bit(n, i - 1), i)
      end
    elsif has_bit?(n, i)
      first_bit = true
    end
  end

  raise ArgumentError, 'no solution'
end

def add_bit(n, i)
  n | (1 << i)
end

def remove_bit(n, i)
  ~add_bit(~n, i)
end

RSpec.describe 'same bits functions' do
  %i(a b).each do |implementation|
    describe "#{implementation} case" do
      describe 'next_smallest' do
        subject { send("next_smallest_#{implementation}", n).to_s(2) }

        context 'has solution' do
          let(:n) { '10101'.to_i(2) }

          it { is_expected.to eq '10110' }
        end

        context 'has solution 1' do
          let(:n) { '1'.to_i(2) }

          it { is_expected.to eq '10' }
        end

        context 'also has solution' do
          let(:n) { '111'.to_i(2) }

          it { is_expected.to eq '1011' }
        end

        context 'no solution 0' do
          let(:n) { '0'.to_i(2) }

          it { expect { subject }.to raise_error(ArgumentError, /no solution/) }
        end

        context 'no solution' do
          let(:n) { '1111111111111111111111111111111111111111111111111111111111111111'.to_i(2) }

          it { expect { subject }.to raise_error(ArgumentError, /no solution/) }
        end
      end

      describe 'prev_biggest' do
        subject { send("prev_biggest_#{implementation}", n).to_s(2) }

        context 'has solution' do
          let(:n) { '10101'.to_i(2) }

          it { is_expected.to eq '10011' }
        end

        context 'no solution' do
          let(:n) { '111'.to_i(2) }

          it { expect { subject }.to raise_error(ArgumentError, /no solution/) }
        end
      end
    end
  end
end
