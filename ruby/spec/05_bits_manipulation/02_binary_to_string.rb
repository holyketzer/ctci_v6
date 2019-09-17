# Time = O(1), Mem = O(1)
def binary_to_string(d)
  res = []
  v = d

  while v != 0 do
    v *= 2

    if v >= 1
      res << 1
      v -= 1
    else
      res << 0
    end

    if res.size > 32
      raise ArgumentError, "#{d} can't be converted to 32 bits binary"
    end
  end

  '0.' + res.map(&:to_s).join
end

RSpec.describe 'binary_to_string' do
  subject { binary_to_string(d) }

  context 'convertable 0.5' do
    let(:d) { 0.5 }

    it { is_expected.to eq '0.1' }
  end

  context 'convertable 0.25' do
    let(:d) { 0.25 }

    it { is_expected.to eq '0.01' }
  end

  context 'convertable 0.0009765625' do
    let(:d) { 0.0009765625 }

    it { is_expected.to eq '0.0000000001' }
  end

  context 'convertable 0.5009765625' do
    let(:d) { 0.5009765625 }

    it { is_expected.to eq '0.1000000001' }
  end

  context 'not convertable' do
    let(:d) { 0.72 }

    it do
      expect { subject }.to raise_error(
        ArgumentError,
        "0.72 can't be converted to 32 bits binary"
      )
    end
  end
end
