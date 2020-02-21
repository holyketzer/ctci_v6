module LRU
  class Node
    attr_accessor :next_node, :prev_node
    attr_reader :value

    def initialize(value, next_node: nil, prev_node: nil)
      @value = value
      @next_node = next_node
      @prev_node = prev_node
    end
  end

  class LinkedList
    attr_reader :head, :tail

    def add_value(v)
      node = Node.new(v)

      if head
        tail.next_node = node
        node.prev_node = tail
        @tail = node
      else
        @head = @tail = node
      end

      node
    end

    def move_to_tail(node)
      if node != tail
        if node == head
          @head = head.next_node
        else
          node.prev_node.next_node = node.next_node
          node.next_node.prev_node = node.prev_node
        end

        tail.next_node = node
        node.prev_node = tail
        node.next_node = nil
        @tail = node
      end
    end

    def remove_head
      if head
        node = head
        @head = head.next_node
        node
      end
    end
  end

  class Pair
    attr_accessor :key, :value

    def initialize(k, v)
      @key = k
      @value = v
    end
  end

  class Cache
    # Mem=O(n)
    def initialize(max_size = 100)
      @max_size = max_size
      @list = LinkedList.new
      @hash = {}
    end

    # Time=O(1)
    def get(key)
      if (node = @hash[key])
        @list.move_to_tail(node)
        node.value.value
      end
    end

    # Time=O(1)
    def add(key, value)
      if (node = @hash[key])
        node.value.value = value
        @list.move_to_tail(node)
      else
        node = @list.add_value(Pair.new(key, value))
        @hash[key] = node
      end

      compact
      value
    end

    def compact
      if @hash.size > @max_size
        head = @list.remove_head
        @hash.delete(head.value.key)
      end
    end

    def size
      @hash.size
    end
  end

  RSpec.describe 'Cache' do
    include LRU

    let(:cache) { Cache.new(4) }

    it do
      expect(cache.size).to eq 0

      cache.add(:x, 1)
      cache.add(:y, 2)
      cache.add(:z, 3)
      cache.add(:a, 4)
      cache.add(:b, 5)

      expect(cache.size).to eq 4
      expect(cache.get(:x)).to eq nil
      expect(cache.get(:b)).to eq 5

      expect(cache.get(:y)).to eq 2
      cache.add(:c, 6)
      expect(cache.get(:z)).to eq nil

      cache.add(:b, 55)
      expect(cache.get(:b)).to eq 55

      cache.add(:d, 7)
      expect(cache.get(:a)).to eq nil
    end
  end
end
