# Time = O(M * log N) Mem = O(log N)
def search_in_matrix_a(m, v)
  m.each_with_index do |row, row_index|
    if col_index = binary_search(row, v)
      return [row_index, col_index]
    end
  end

  nil
end

def binary_search(row, v, l = 0, r = row.size - 1)
  m = (r + l) / 2

  if row[m] == v
    return m
  elsif l >= r
    return nil
  elsif row[m] < v
    l = m + 1
  else
    r = m - 1
  end

  binary_search(row, v, l, r)
end

# Time = O(M * log N) Mem = O(log N)
def search_in_matrix_b(m, v)
  tlr, tlc = *find_top_left(m, v)
  brr, brc = *find_bottom_right(m, v)

  m.each_with_index do |row, row_index|
    l = row_index <= tlr ? tlc + 1 : 0
    r = row_index >= brr ? brc - 1 : m[0].size - 1

    if col_index = binary_search(row, v, l, r)
      return [row_index, col_index]
    end
  end

  nil
end

def find_top_left(m, v)
  c = find_col_edge(m, 0, v, :<)
  r = find_row_edge(m, c, v, :<)
  [r, c]
end

def find_bottom_right(m, v)
  c = find_col_edge(m, m.size - 1, v, :>)
  r = find_row_edge(m, c, v, :>)
  [r, c]
end

def find_row_edge(m, c, v, op, l = 0, r = m.size - 1)
  i = (l + r) / 2

  if i == m.size - 1
    return i
  elsif op == :<
    if i == 0
      return i
    elsif m[i][c] < v && !(m[i + 1][c] < v)
      return i
    elsif m[i][c] < v
      l = i + 1
    else
      r = i - 1
    end
  else
    if i == 0
      return i + 1
    elsif m[i][c] <= v && m[i + 1][c] > v
      return i + 1
    elsif m[i][c] < v
      l = i + 1
    else
      r = i - 1
    end
  end

  find_row_edge(m, c, v, op, l, r)
end

def find_col_edge(m, r, v, op, t = 0, b = m[0].size - 1)
  i = (t + b) / 2

  if i == m[0].size - 1
    return i
  elsif op == :<
    if i == 0
      return i
    elsif m[r][i] < v && m[r][i + 1] >= v
      return i
    elsif m[r][i] < v
      t = i + 1
    else
      b = i - 1
    end
  else
    if i == 0
      return i + 1
    elsif m[r][i] <= v && m[r][i + 1] > v
      return i + 1
    elsif m[r][i] < v
      t = i + 1
    else
      b = i - 1
    end
  end

  find_col_edge(m, r, v, op, t, b)
end

RSpec.describe 'search_in_matrix' do
  %i(a b).each do |implementation|
    describe "#{implementation} case" do
      subject { send("search_in_matrix_#{implementation}", m, v) }

      let(:m) do
        [
          [ 1,  2,  3,  4,  5],
          [10, 20, 30, 41, 50],
          [20, 30, 40, 50, 60],
        ]
      end

      context 'find 5' do
        let(:v) { 5 }

        it { is_expected.to eq [0, 4] }
      end

      context 'find 35' do
        let(:v) { 35 }

        it { is_expected.to eq nil }
      end

      context 'find 40' do
        let(:v) { 40 }

        it { is_expected.to eq [2, 2] }
      end

      context 'find 61' do
        let(:v) { 61 }

        it { is_expected.to eq nil }
      end
    end
  end
end
