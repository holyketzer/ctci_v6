def queens_position_count(desk, q)
  if q == 0
    if only_this_file_run?(__FILE__)
      puts desk_to_s(desk)
    end
    1
  else
    res = 0
    row = q - 1

    8.times do |col|
      if possible_place?(desk, row, col)
        desk[row][col] = true
        res += queens_position_count(desk, q - 1)
        desk[row][col] = false
      end
    end

    res
  end
end

def possible_place?(desk, row, col)
  free_row?(desk, row) && free_col?(desk, col) && free_diagonal?(desk, row, col)
end

def free_row?(desk, row)
  8.times.map.all? { |col| desk[row][col] == false }
end

def free_col?(desk, col)
  8.times.map.all? { |row| desk[row][col] == false }
end

def free_diagonal?(desk, row, col)
  moves = [
    [-1, -1], # nw
    [-1, 1], # ne
    [1, 1], # se
    [1, -1], # sw
  ]

  moves.all? do |dr, dc|
    diagnal_cells(row, col, dr, dc).all? { |r, c| desk[r][c] == false }
  end
end

def diagnal_cells(row, col, dr, dc)
  Enumerator.new do |e|
    while row >= 0 && row < 8 && col >= 0 && col < 8 do
      e << [row, col]
      row += dr
      col += dc
    end
  end
end

def desk_to_s(desk)
  desk.map do |row|
    row.map { |c| c ? 'Q' : '.' }.join(' ')
  end.join("\n") + "\n\n"
end

RSpec.describe 'queens_position_count' do
  subject { queens_position_count(desk, 8) }

  let(:desk) { 8.times.map { Array.new(8) { |_| false } } }

  it do
    # desk[0][0] = true
    # p possible_place?(desk, 1, 0)
    expect(subject).to eq 92
  end
end
