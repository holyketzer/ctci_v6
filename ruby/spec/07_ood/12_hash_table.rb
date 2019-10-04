class HashTable
  class KV
    attr_reader :k, :v

    def initialize(k, v)
      @k = k
      @v = v
    end
  end

  def initialize(size = 16)
    @buckets = Array.new(size)
  end

  def get_index(key)
    key.hash % @buckets.size
  end

  def []=(key, value)
    i = get_index(key)
    kv = KV.new(key, value)

    if (bucket = @buckets[i])
      insert_to_bucket(bucket, kv)
    else
      @buckets[i] = LinkedList.new(kv)
    end

    self
  end

  def insert_to_bucket(list, kv)
    list.each do |node|
      if node.value.k == kv.k
        node.value = kv
        return
      end
    end

    list.push(kv)
  end

  def [](key)
    if (bucket = @buckets[get_index(key)])
      bucket.each do |node|
        if node.value.k == key
          return node.value.v
        end
      end
    end
  end

  def delete(key)
    if (bucket = @buckets[get_index(key)])
      head = bucket.head

      if head.value.k == key
        bucket.remove_first
        return head.value.v
      else
        prev = head

        while head do
          if head.value.k == key
            prev.next_node = head.next_node
            return head.value.v
          end

          head = head.next_node
        end
      end
    end
  end

  def each_kv(&block)
    @buckets.each do |bucket|
      bucket&.each do |node|
        block.call(node.value)
      end
    end
  end

  def keys
    res = []
    each_kv { |kv| res << kv.k }
    res.sort
  end

  def values
    res = []
    each_kv { |kv| res << kv.v }
    res.sort
  end

  def size
    res = 0
    each_kv { |kv| res += 1 }
    res
  end
end

RSpec.describe 'HashTable' do
  let(:hash) { HashTable.new }

  it do
    expect(hash.size).to eq 0
    expect(hash.keys).to eq []
    expect(hash.values).to eq []

    hash[:x] = 11
    hash[:y] = 12

    expect(hash.size).to eq 2
    expect(hash.keys).to eq [:x, :y]
    expect(hash.values).to eq [11, 12]

    # Collision
    16.times do |i|
      hash[i] = i.to_s
    end

    expect(hash.size).to eq 18

    16.times do |i|
      expect(hash.delete(i)).to eq i.to_s
    end
    expect(hash.size).to eq 2

    # Not existing keys
    expect(hash[:zz]).to eq nil

    # Overwriting
    hash[:x] = 33
    expect(hash[:x]).to eq 33
    expect(hash.size).to eq 2

    expect(hash.delete(:x)).to eq 33
    expect(hash.delete(:y)).to eq 12
    expect(hash.size).to eq 0
  end
end
