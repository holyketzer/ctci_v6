WORD_SIZE_BITS = 64

def negate(a)
  # Mistake 1: don't consider case with 0, it can be negated by this algorithm
  if a == 0
    a
  else
    sign_bit = ~a & (1 << (WORD_SIZE_BITS - 1))
    value_bits = a & ~(1 << (WORD_SIZE_BITS - 1))
    value_bits = ((~value_bits) + 1) & ~(1 << (WORD_SIZE_BITS - 1))
    sign_bit | value_bits
  end
end

def subtract(a, b)
  a + negate(b)
end

def multiply(a, b)
  res = 0

  if a < 0 && b < 0
    a = a.abs
    b = b.abs
  elsif a < 0 && b > 0
    a, b = b, a
  end

  a.times { res += b }
  res
end

def divide(a, b)
  res = 0
  negative = false

  # Mistake 2: forgot to check for negative cases
  if a < 0 && b < 0
    a = a.abs
    b = b.abs
  elsif a < 0 || b < 0
    a = a.abs
    b = b.abs
    negative = true
  end

  while a > b do
    a = subtract(a, b)
    res += 1
  end

  negative ? negate(res) : res
end

RSpec.describe 'operations' do
  describe '#negate' do
    subject { negate(a) }

    context '10' do
      let(:a) { 10 }

      it { is_expected.to eq(-10) }
    end

    context '0' do
      let(:a) { 0 }

      it { is_expected.to eq 0 }
    end

    context '-10' do
      let(:a) { -10 }

      it { is_expected.to eq 10 }
    end
  end

  describe '#subtract' do
    subject { subtract(a, b) }

    context '10 - 3' do
      let(:a) { 10 }
      let(:b) { 3 }

      it { is_expected.to eq 7 }
    end

    context '5 - 6' do
      let(:a) { 5 }
      let(:b) { 6 }

      it { is_expected.to eq(-1) }
    end
  end

  describe '#multiply' do
    subject { multiply(a, b) }

    context '10 * 3' do
      let(:a) { 10 }
      let(:b) { 3 }

      it { is_expected.to eq 30 }
    end

    context '-10 * -3' do
      let(:a) { -10 }
      let(:b) { -3 }

      it { is_expected.to eq 30 }
    end

    context '5 * -6' do
      let(:a) { 5 }
      let(:b) { -6 }

      it { is_expected.to eq(-30) }
    end

    context '-5 * 6' do
      let(:a) { -5 }
      let(:b) { 6 }

      it { is_expected.to eq(-30) }
    end
  end

  describe '#divide' do
    subject { divide(a, b) }

    context '10 / 3' do
      let(:a) { 10 }
      let(:b) { 3 }

      it { is_expected.to eq 3 }
    end

    context '-10 / -3' do
      let(:a) { -10 }
      let(:b) { -3 }

      it { is_expected.to eq 3 }
    end

    context '5 / -6' do
      let(:a) { 5 }
      let(:b) { -6 }

      it { is_expected.to eq 0 }
    end

    context '-5 * 6' do
      let(:a) { -5 }
      let(:b) { 6 }

      it { is_expected.to eq 0 }
    end
  end
end
# a / b = c
# c * b = a
