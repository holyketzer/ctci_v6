def tripple_step(n)
  arr = [1, 2, 4]

  if n < 1
    raise ArgumentError, "should be > 0"
  elsif n >= 4
    (3..(n - 1)).each do |i|
      arr << arr[i - 1] + arr[i - 2] + arr[i - 3]
    end
  end

  arr[n - 1]
end

RSpec.describe 'tripple_step' do
  subject { tripple_step(n) }

  it do
    expect { tripple_step(0) }.to raise_error(ArgumentError)

    expect(tripple_step(1)).to eq 1
    expect(tripple_step(2)).to eq 2
    expect(tripple_step(3)).to eq 4
    expect(tripple_step(4)).to eq 7
    expect(tripple_step(5)).to eq 13
    expect(tripple_step(6)).to eq 24
    expect(tripple_step(7)).to eq 44
  end
end
