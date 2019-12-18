def factorial_zeros(n)
  fives = 0

  (1..n).each do |i|
    fives += fives_count(i)
  end

  fives
end

def fives_count(n)
  res = 0

  while n > 0 && n % 5 == 0
    res += 1
    n = n / 5
  end

  res
end

RSpec.describe 'factorial_zeros?' do
  subject { factorial_zeros?(field) }

  it do
    {
      0 => 0,
      1 => 0,
      2 => 0,
      3 => 0,
      4 => 0,
      5 => 1,
      6 => 1,
      7 => 1,
      8 => 1,
      9 => 1,
      10 => 2,
      11 => 2,
      12 => 2,
      13 => 2,
      14 => 2,
      15 => 3,
      16 => 3,
      20 => 4,
      21 => 4,
      25 => 6,
      26 => 6,
    }.each do |n, trailing_zeros|
      expect(factorial_zeros(n)).to eq trailing_zeros
    end
  end
end
