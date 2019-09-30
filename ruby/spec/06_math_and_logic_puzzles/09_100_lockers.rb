def hundreed_lockers_a(lockers_open)
  (2..100).each do |n|
    i = n - 1
    while i < 100 do
      lockers_open[i] = !lockers_open[i]
      i += n
    end
  end

  lockers_open
end

def hundreed_lockers_b(lockers_open)
  (2..100).each do |n|

    primes = to_prime_numbers(n)

    lockers_open[n - 1] = primes.uniq.count % 2 == 0
  end

  lockers_open
end

def to_prime_numbers(n)
  res = []
  i = 2

  while i <= n do
    if n % i == 0
      res << i
    end

    i += 1
  end

  res
end

RSpec.describe 'hundreed_lockers' do
  %i(a b).each do |implementation|
    describe "#{implementation} case" do
      subject { send("hundreed_lockers_#{implementation}", lockers_open) }

      let(:lockers_open) { 100.times.map { true } }

      it do

        expect(subject.count { |v| v == true }).to eq 10
      end
    end
  end
end
