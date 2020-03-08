module KthMultiple
  # Time=O(n * n) Mem=O(n)
  def solve_a(n, multipliers = [3, 5, 7])
    set = Set.new([1])
    res = [1]

    i = 0
    j = 0

    while res.size < n do
      x = res[i] * multipliers[j]
      move = true

      if !set.include?(x)
        i2 = i + 1
        j2 = 0
        y = x

        while i2 < res.size && j2 < multipliers.size - 1 && res[i2] * multipliers[0] < x do
          y = res[i2] * multipliers[j2]

          if y < x && !set.include?(y)
            x = y
            move = false
            break
          else
            j2 += 1

            if j2 == multipliers.size - 1
              j2 = 0
              i2 += 1
            end
          end
        end

        res << x
        set << x
      end

      if move
        j += 1
      end

      if j == multipliers.size
        j = 0
        i += 1
      end
    end

    res
  end

  # Time=O(n) Mem=O(n)
  def solve_b(n, multipliers = [3, 5, 7])
    # 1 3 9
    # 5 15
    # 7 21
    res = []

    queues = multipliers.map { |m| [m, SortedSet.new] }.to_h
    queues[multipliers.first] << 1

    while res.size < n do
      m, q = queues.select { |_, q| q.size > 0 }.min_by { |_, q| q.first }

      x = queues[m].first
      queues[m].delete(x)

      res << x

      multipliers.each do |m|
        nx = x * m

        if queues.all? { |_, set| !set.include?(nx) }
          queues[m] << nx
        end
      end
    end

    res
  end

  RSpec.describe 'KthMultiple' do
    include KthMultiple

    %i(a b).each do |implementation|
      context "implementation #{implementation}" do
        subject { send("solve_#{implementation}", n) }

        context 'n == 7' do
          let(:n) { 7 }

          it { is_expected.to eq [1, 3, 5, 7, 9, 15, 21] }
        end

        context 'n == 10' do
          let(:n) { 10 }

          it { is_expected.to eq [1, 3, 5, 7, 9, 15, 21, 25, 27, 35] }
        end

        context 'n == 13' do
          let(:n) { 13 }

          it { is_expected.to eq [1, 3, 5, 7, 9, 15, 21, 25, 27, 35, 45, 49, 63] }
        end
      end
    end
  end
end
