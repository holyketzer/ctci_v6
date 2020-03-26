module VolumeOfHistogram
  # Time=O(n^2) Mem=O(n)
  def solve_a(historgram)
    prev_peak = historgram[0]
    prev_peak_index = 0
    volume = [0] * historgram.size

    historgram.each_with_index do |h, i|
      if h > prev_peak
        ((prev_peak_index + 1)..(i - 1)).each do |pi|
          new_volume = prev_peak - historgram[pi]

          if new_volume > volume[pi]
            volume[pi] = new_volume
          end
        end

        prev_peak = h
        prev_peak_index = i
      else
        ((prev_peak_index + 1)..(i - 1)).each do |pi|
          curr = historgram[i]
          new_volume = curr - historgram[pi]

          if new_volume > volume[pi]
            volume[pi] = new_volume
          end
        end
      end
    end

    volume.sum
  end

  # Time=O(n) Mem=O(n)
  def solve_b(historgram)
    left_maxes = [0] * historgram.size
    rigth_maxes = [0] * historgram.size

    lmax = historgram.first
    rmax = historgram.last

    historgram.size.times do |i|
      l = historgram[i]

      if l > lmax
        lmax = l
      end

      left_maxes[i] = lmax

      r = historgram[historgram.size - i - 1]

      if r > rmax
        rmax = r
      end

      rigth_maxes[historgram.size - i - 1] = rmax
    end

    volume = 0

    historgram.each_with_index do |h, i|
      lowest_top = left_maxes[i] < rigth_maxes[i] ? left_maxes[i] : rigth_maxes[i]

      if lowest_top > h
        volume += lowest_top - h
      end
    end

    volume
  end

  RSpec.describe 'VolumeOfHistogram' do
    include VolumeOfHistogram

    %i(a b).each do |implementation|
      context "implementation #{implementation}" do
        subject { send("solve_#{implementation}", historgram) }

        context 'book example' do
          let(:historgram) { [0, 0, 4, 0, 0, 6, 0, 0, 3, 0, 5, 0, 1, 0, 0, 0] }

          it { is_expected.to eq 26 }
        end
      end
    end
  end
end
