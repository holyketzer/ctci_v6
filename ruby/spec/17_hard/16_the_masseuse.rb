module TheMasseuse
  # Time=O(n) Mem=O(n)
  def solve_a(seq, index = 0, cache = {})
    if index >= seq.size
      return 0
    end

    if cache.include?(index)
      return cache[index]
    end

    # Take appointment
    best_with = seq[index] + solve_a(seq, index + 2, cache)

    # Or skip appointment
    best_without = solve_a(seq, index + 1, cache)

    cache[index] = best_with > best_without ? best_with : best_without
  end

  # Time=O(n) Mem=O(1)
  def solve_b(seq)
    best = 0
    best_prev = 0
    best_prev_prev = 0
    i = seq.size - 1

    while i >= 0 do
      best = [seq[i] + best_prev_prev, best_prev].max

      i -= 1

      best_prev_prev = best_prev
      best_prev = best
    end

    best
  end

  RSpec.describe 'TheMasseuse' do
    include TheMasseuse

    %i(a b).each do |implementation|
      context "implementation #{implementation}" do
        subject { send("solve_#{implementation}", seq) }

        let(:seq) { [30, 15, 60, 75, 45, 15, 15, 45] }

        it { is_expected.to eq 180 }
      end
    end
  end
end
