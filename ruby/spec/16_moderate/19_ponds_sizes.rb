module PondsSizes
  def solve(m)
    ponds = []

    each_cell(m) do |row, col, v|
      if v == 0
        ponds << get_pond_size(m, row, col)
      end
    end

    each_cell(m) do |row, col, v|
      recover_pond(m, row, col)
    end

    ponds
  end

  def recover_pond(m, row, col)
    if m[row][col] == nil
      m[row][col] = 0
    end
  end

  def each_cell(m, &block)
    m.each_with_index do |row, ri|
      row.each_with_index do |v, ci|
        block.call(ri, ci, v)
      end
    end
  end

  def get_pond_size(m, row, col)
    size = 0
    queue = [[row, col]]

    while queue.size > 0 do
      size += 1
      row, col = *queue.shift
      m[row][col] = nil
      queue += nearest_ponds(m, row, col)
    end

    size
  end

  def nearest_ponds(m, row, col)
    res = []

    [-1, 0, 1].each do |dr|
      [-1, 0, 1].each do |dc|
        r = row + dr
        c = col + dc

        if r >= 0 && r < m.size && c >= 0 && c < m[0].size && m[r][c] == 0
          res << [r, c]
        end
      end
    end

    res
  end

  RSpec.describe 'solve' do
    include PondsSizes

    subject { solve(m) }

    let(:m) do
      [
        [0, 2, 1, 0],
        [0, 1, 0, 1],
        [1, 1, 0, 1],
        [0, 1, 0, 1],
      ]
    end

    it { expect(subject.sort).to eq [1, 2, 4] }
  end
end
