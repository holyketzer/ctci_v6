# Time, Mem = O(sqrt(min(a, b)))
def multiply(a, b)
  if a < b
    a, b = b, a
  end

  if b == 0
    0
  elsif b == 1
    a
  elsif b == 2
    a + a
  else
    hb = b >> 1
    subres = multiply(a, hb)

    if hb + hb == b # even
      subres + subres
    else # odd
      subres + subres + a
    end
  end
end

RSpec.describe 'multiply' do
  it do
    [
      [1, 0],
      [100, 33],
      [100000, 99999999]
    ].each do |a, b|
      expect(multiply(a, b)).to eq a * b
    end
  end
end
