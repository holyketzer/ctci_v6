WORD_SIZE_BITS = 0.size * 8

def max(a, b)
  # Are signs different
  ds = has_negative_bit?(a ^ b)

  k = ((~ds) & 1) * has_negative_bit?(b - a) + ds * has_negative_bit?(b)

  a * k + b * ((~k) & 1)
end

def has_negative_bit?(x)
  (x & (1 << (WORD_SIZE_BITS - 1))) >> (WORD_SIZE_BITS - 1)
end

RSpec.describe 'max' do
  subject { max(a, b) }

  context 'both positive' do
    let(:a) { 10 }
    let(:b) { 3 }

    it { is_expected.to eq 10 }
  end

  context 'both negative' do
    let(:a) { -10 }
    let(:b) { -3 }

    it { is_expected.to eq(-3) }
  end

  context 'different signs' do
    let(:a) { -10 }
    let(:b) { 3 }

    it { is_expected.to eq 3 }
  end

  # There is no overflow in Ruby possible, but in another platform is
  context 'with overflow' do
    let(:a) { -1 }
    let(:b) { 18446744073709551615 }

    it { is_expected.to eq b }
  end
end

def to_bin_str(x)
  byte_size = x.size

  res = []

  (byte_size * 8).times do |bit|
    if (x & (1 << bit)) > 0
      res << '1'
    else
      res << '0'
    end
  end

  res.reverse.join
end
