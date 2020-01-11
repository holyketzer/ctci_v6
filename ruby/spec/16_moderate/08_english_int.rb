LEVEL_TO_ENG = {
  1 => '',
  2 => 'thousand',
  3 => 'million',
  4 => 'billion',
  5 => 'trillion',
}.freeze

SMALL_NUM_TO_ENG = {
  0 => '',
  1 => 'one',
  2 => 'two',
  3 => 'three',
  4 => 'four',
  5 => 'five',
  6 => 'six',
  7 => 'seven',
  8 => 'eight',
  9 => 'nine',
  10 => 'ten',
  11 => 'eleven',
  12 => 'twelve',
  13 => 'thirteen',
  14 => 'fourteen',
  15 => 'fiveteen',
  16 => 'sixteen',
  17 => 'seventeen',
  18 => 'eighteen',
  19 => 'nineteen',
}.freeze

TENS_TO_ENG = {
  2 => 'twenty',
  3 => 'thirty',
  4 => 'fourty',
  5 => 'fifty',
  6 => 'sixty',
  7 => 'seventy',
  8 => 'eighty',
  9 => 'ninety',
}.freeze

def int_to_english(v)
  res = []

  if v == 0
    res << 'zero'
  else
    each_three_decimal(v.abs) do |level, value|
      res += small_int_to_english(value)
      res << LEVEL_TO_ENG.fetch(level)
    end

    if v < 0
      res.insert(0, 'minus')
    end
  end

  res.reject(&:empty?).join(' ')
end

def small_int_to_english(v)
  if v < 20
    [SMALL_NUM_TO_ENG[v]]
  elsif v < 100
    [TENS_TO_ENG[v / 10], SMALL_NUM_TO_ENG[v % 10]]
  else
    [SMALL_NUM_TO_ENG[v / 100], 'hundred', *small_int_to_english(v % 100)]
  end
end

def each_three_decimal(v, &block)
  v = v.to_s
  level = v.size / 3
  i = v.size % 3

  if i > 0
    level += 1
    block.call(level, v[0, i].to_i)
    level -= 1
  end

  while level > 0 do
    block.call(level, v[i, 3].to_i)
    level -= 1
    i += 3
  end
end

RSpec.describe 'int_to_english' do
  subject { int_to_english(v) }

  context '0' do
    let(:v) { 0 }

    it { is_expected.to eq 'zero' }
  end

  context '1' do
    let(:v) { 1 }

    it { is_expected.to eq 'one' }
  end

  context '-1' do
    let(:v) { -1 }

    it { is_expected.to eq 'minus one' }
  end

  context '12' do
    let(:v) { 12 }

    it { is_expected.to eq 'twelve' }
  end

  context '25' do
    let(:v) { 25 }

    it { is_expected.to eq 'twenty five' }
  end

  context '70' do
    let(:v) { 70 }

    it { is_expected.to eq 'seventy' }
  end

  context '99' do
    let(:v) { 99 }

    it { is_expected.to eq 'ninety nine' }
  end

  context '100' do
    let(:v) { 100 }

    it { is_expected.to eq 'one hundred' }
  end

  context '119' do
    let(:v) { 119 }

    it { is_expected.to eq 'one hundred nineteen' }
  end

  context '800' do
    let(:v) { 800 }

    it { is_expected.to eq 'eight hundred' }
  end

  context '902' do
    let(:v) { 902 }

    it { is_expected.to eq 'nine hundred two' }
  end

  context '937' do
    let(:v) { 937 }

    it { is_expected.to eq 'nine hundred thirty seven' }
  end

  context '1000' do
    let(:v) { 1000 }

    it { is_expected.to eq 'one thousand' }
  end

  context '1003' do
    let(:v) { 1003 }

    it { is_expected.to eq 'one thousand three' }
  end

  context '1014' do
    let(:v) { 1014 }

    it { is_expected.to eq 'one thousand fourteen' }
  end

  context '1200' do
    let(:v) { 1200 }

    it { is_expected.to eq 'one thousand two hundred' }
  end

  context '1345' do
    let(:v) { 1345 }

    it { is_expected.to eq 'one thousand three hundred fourty five' }
  end

  context '-2_147_483_648' do
    let(:v) { -2_147_483_648 }

    it { is_expected.to eq 'minus two billion one hundred fourty seven million four hundred eighty three thousand six hundred fourty eight' }
  end
end
