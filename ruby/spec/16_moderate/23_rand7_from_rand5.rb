module Rand7FromRand5
  def rand5
    rand(5)
  end

  def rand7
    while true do
      v = 5 * rand5 + rand5

      if v < 21
        return v % 7
      end
    end
  end

  RSpec.describe 'rand7' do
    include Rand7FromRand5

    it do
      total = 10_000
      res = Hash.new { |hash, key| hash[key] = 0 }
      total.times { res[rand7] += 1 }

      res.keys.each do |key|
        res[key] /= total.to_f
        expect(res[key]).to be_within(0.01).of(1.0 / 7.0)
      end
    end
  end
end
