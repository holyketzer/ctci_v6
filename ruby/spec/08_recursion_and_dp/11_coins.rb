def coins_combinations_count(n, coins, max = coins.last, res = [])
  if n == coins[0] || n == 0
    comnination = n > 0 ? (res + [n]).sort : res.sort
    1
  elsif n < coins[0]
    0
  else
    coins.select { |c| c <= n && c <= max }.sum do |c|
      res << c
      count = coins_combinations_count(n - c, coins, c, res) #.tap { |res| puts "n=#{n} c=#{c} res=#{res}" }
      res.pop
      count
    end
  end
end

RSpec.describe 'coins_combinations_count' do
  let(:coins) { [1, 5, 10, 25] }

  it do
    expect(coins_combinations_count(1, coins)).to eq 1
    expect(coins_combinations_count(2, coins)).to eq 1
    expect(coins_combinations_count(3, coins)).to eq 1
    expect(coins_combinations_count(4, coins)).to eq 1
    expect(coins_combinations_count(5, coins)).to eq 2
    expect(coins_combinations_count(6, coins)).to eq 2
    expect(coins_combinations_count(7, coins)).to eq 2
    expect(coins_combinations_count(8, coins)).to eq 2
    expect(coins_combinations_count(9, coins)).to eq 2
    expect(coins_combinations_count(10, coins)).to eq 4
    expect(coins_combinations_count(11, coins)).to eq 4
    expect(coins_combinations_count(15, coins)).to eq 6
    expect(coins_combinations_count(100, coins)).to eq 242
  end
end
