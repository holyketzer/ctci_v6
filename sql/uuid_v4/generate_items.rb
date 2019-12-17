def generate_items(n)
  puts "INSERT INTO items (value) VALUES"

  (n - 1).times do |i|
    puts generate_line(i) + ','
  end

  puts generate_line(n) + ';'
end

def generate_line(i)
  "(#{i})"
end

total = 9000_000
batch = 100_000

(total / batch).times do
  generate_items(batch)
end
