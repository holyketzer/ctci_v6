# n - count of lines in file
# Mem = O(1) [~ 512 MB], Time = O(n)
def missing_int_a(path, total: 2 ** 32)
  int_byte_size = 0.size # count of bytes in int
  bucket_size = int_byte_size * 8 # count of bits in int
  buckets_count = total / bucket_size
  max_bucket_value = 1 << bucket_size

  arr = Array.new(buckets_count, 0)

  each_value(path) do |v|
    arr[v / bucket_size] |= (1 << v % bucket_size)
  end

  arr.each_with_index do |v, index|
    if v < max_bucket_value
      (0..(bucket_size - 1)).each do |bit|
        if v & (1 << bit) == 0
          return bucket_size * index + bit
        end
      end
    end
  end

  nil
end

def missing_int_b(path, total: 2 ** 32, memory_limit: 2 ** 23) # memory limit 8 MB
  int_byte_size = 0.size # count of bytes in int
  buckets_count =(memory_limit / int_byte_size.to_f).ceil
  bucket_range = total / buckets_count

  arr = Array.new(buckets_count, 0)

  each_value(path) do |v|
    arr[v / buckets_count] += 1
  end

  offset = 0

  arr.each_with_index do |v, index|
    if v < bucket_range
      offset = index
      break
    end
  end

  from = bucket_range * offset
  to = from + bucket_range
  bucket_size = int_byte_size * 8 # count of bits in int
  buckets_count = bucket_range / bucket_size
  max_bucket_value = 1 << bucket_size

  arr = Array.new(buckets_count, 0)

  each_value(path) do |v|
    if v >= from && v < to
      arr[(v - from) / bucket_size] |= (1 << (v - from) % bucket_size)
    end
  end

  arr.each_with_index do |v, index|
    if v < max_bucket_value
      (0..(bucket_size - 1)).each do |bit|
        if v & (1 << bit) == 0
          return from + bucket_size * index + bit
        end
      end
    end
  end

  nil
end

def each_value(path, &block)
  File.open(path) do |f|
    f.each_line do |line|
      block.call(line.to_i)
    end
  end
end

RSpec.describe 'missing_int' do
  %i(a b).each do |implementation|
    describe "#{implementation} case" do
      subject { send("missing_int_#{implementation}", path, total: total) }

      let(:path) { 'fixtures/big-file-with-missing-int.txt' }
      let(:total) { implementation == :a ? 1024 : 2 ** 32 }

      it { is_expected.to eq 21 }
    end
  end
end
