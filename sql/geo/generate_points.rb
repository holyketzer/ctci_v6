CENTER_X = 37.617635
CENTER_Y = 55.755814
DX = 2
DY = 2

RANGE_X = (CENTER_X - DX / 2)..(CENTER_X + DX / 2)
RANGE_Y = (CENTER_Y - DY / 2)..(CENTER_Y + DY / 2)

def generate_points(n)
  puts "INSERT INTO points (p) VALUES"

  (n - 1).times do
    puts generate_line + ','
  end

  puts generate_line + ';'
end

def generate_line
  "(point '(#{rand(RANGE_X)},#{rand(RANGE_Y)})')"
end

total = 1000_000
batch = 1000

(total / batch).times do
  generate_points(batch)
end
