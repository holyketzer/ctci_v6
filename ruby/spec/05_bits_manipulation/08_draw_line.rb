# Time = O(1), Mem = O(1)
def draw_line_a(screen, width, x1, x2, y)
  offset = width * y + x1
  target = width * y + x2

  while offset < target do
    to = target / 8 == offset / 8 ? target % 8 : 7
    fill_bit(screen, offset / 8, offset % 8, to)
    offset += (8 - (offset % 8))
  end

  screen
end

def fill_bit(arr, i, from, to)
  if from == 0 && to == 7
    arr[i] = 255
  else
    res = 0
    (from..to).each do |bit|
      res |= (1 << bit)
    end

    arr[i] = res
  end
end

RSpec.describe 'draw_line' do
  %i(a).each do |implementation|
    describe "#{implementation} case" do
      describe 'draw_line' do
        subject { send("draw_line_#{implementation}", screen, width, x1, x2, y) }

        let(:screen) do
          [
            0, 0, 0, 0,
            0, 0, 0, 0,
          ]
        end

        let(:width) {  4 * 8 }
        let(:y) { 1 }
        let(:x1) { 3 }
        let(:x2) { 30 }

        it do
          # Line 1
          expect(subject[0]).to eq 0
          expect(subject[1]).to eq 0
          expect(subject[2]).to eq 0
          expect(subject[3]).to eq 0

          # Line 2
          expect(subject[4].to_s(2)).to eq '11111000'
          expect(subject[5]).to eq 255
          expect(subject[6]).to eq 255
          expect(subject[7].to_s(2)).to eq '1111111'
        end
      end
    end
  end
end
