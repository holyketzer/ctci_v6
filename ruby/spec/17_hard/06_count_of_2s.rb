module CountOf2s
  # Time=O(n) Mem=O(1)
  def solve_a(n)
    res = 0

    (n + 1).times do |i|
      i.to_s.each_char do |c|
        if c == '2'
          res += 1
        end
      end
    end

    res
  end

  # Time=O(log10 n) Mem=O(1)
  def solve_b(n)
    res = 0
    multiplier = 1

    while multiplier < n
      multiplier *= 10

      res += (n / multiplier) * (multiplier / 10)
      res += [[(n % multiplier) - ((2 * multiplier / 10) - 1), multiplier / 10].min, 0].max
    end

    res
  end

  RSpec.describe 'CountOf2s' do
    include CountOf2s

    describe 'reference implementation' do
      it do
        expect(solve_a(0)).to eq 0
        expect(solve_a(1)).to eq 0
        expect(solve_a(2)).to eq 1
        expect(solve_a(10)).to eq 1
        expect(solve_a(11)).to eq 1
        expect(solve_a(12)).to eq 2
        expect(solve_a(19)).to eq 2
        expect(solve_a(20)).to eq 3
        expect(solve_a(22)).to eq 6
        expect(solve_a(25)).to eq 9
      end
    end

    describe 'compare optimized and reference implementations' do
      it do
        100.times do |i|
          x = rand(1_000)
          expect(solve_b(x)).to eq solve_a(x)
        end
      end
    end
  end
end
