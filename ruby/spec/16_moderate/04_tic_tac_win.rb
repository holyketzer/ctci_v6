# For sqaure field
def tic_tac_win?(field)
  field.size.times do |i|
    if (res = check_row(field, i) || check_col(field, i))
      return res
    end
  end

  check_diagonals(field)
end

def check_row(field, row)
  o = 0
  x = 0

  field.size.times do |col|
    if field[row][col] == :x
      x += 1
    elsif field[row][col] == :o
      o += 1
    end
  end

  if x == field.size
    :x
  elsif o == field.size
    :o
  else
    false
  end
end

def check_col(field, col)
  o = 0
  x = 0

  field.size.times do |row|
    if field[row][col] == :x
      x += 1
    elsif field[row][col] == :o
      o += 1
    end
  end

  if x == field.size
    :x
  elsif o == field.size
    :o
  else
    false
  end
end

def check_diagonals(field)
  lx = 0
  lo = 0
  rx = 0
  ro = 0

  field.size.times do |i|
    if field[i][i] == :x
      lx += 1
    elsif field[i][i] == :o
      lo += 1
    end

    if field[i][field.size - i - 1] == :x
      rx += 1
    elsif field[i][field.size - i - 1] == :o
      ro += 1
    end
  end

  if lx == field.size || rx == field.size
    :x
  elsif lo == field.size || ro == field.size
    :o
  else
    false
  end
end

RSpec.describe 'tic_tac_win?' do
  subject { tic_tac_win?(field) }

  context 'no winner' do
    let(:field) do
      [
        [:o, :o, nil],
        [:x, :x, :o],
        [:x, :x, :o],
      ]
    end

    it { is_expected.to eq false }
  end

  context 'row :x winner' do
    let(:field) do
      [
        [:o, :o, nil],
        [:x, :x, :x],
        [:x, :x, :o],
      ]
    end

    it { is_expected.to eq :x }
  end

  context 'col :x winner' do
    let(:field) do
      [
        [:o, :x, nil],
        [:x, :x, :o],
        [:x, :x, :o],
      ]
    end

    it { is_expected.to eq :x }
  end

  context 'diagonal :x winner' do
    let(:field) do
      [
        [:o, :o, :x],
        [:x, :x, :o],
        [:x, :x, :o],
      ]
    end

    it { is_expected.to eq :x }
  end

  context 'row :o winner' do
    let(:field) do
      [
        [:o, :o, :o],
        [:x, :x, nil],
        [:x, :x, :o],
      ]
    end

    it { is_expected.to eq :o }
  end

  context 'col :o winner' do
    let(:field) do
      [
        [nil, :o, :o],
        [:x, :x, :o],
        [:x, :x, :o],
      ]
    end

    it { is_expected.to eq :o }
  end

  context 'diagonal :o winner' do
    let(:field) do
      [
        [:o, nil, :o],
        [:x, :o, :x],
        [:x, :x, :o],
      ]
    end

    it { is_expected.to eq :o }
  end
end
