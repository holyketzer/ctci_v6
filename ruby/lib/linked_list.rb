# Linked List
class LLNode
  attr_accessor :value, :next_node

  def initialize(value, next_node=nil)
    @value = value
    @next_node = next_node
  end
end

class LinkedList
  attr_reader :head

  def initialize(arr = nil)
    @head = ll(Array(arr))
  end

  def push(value)
    @head = ll_add_value(@head, value)
  end

  def pop
    if @head
      value = @head.value
      @head = @head.next_node
      value
    end
  end

  def to_array
    ll_to_array(@head)
  end

  def empty?
    @head == nil
  end

  def head_value
    @head.value
  end

  def each(&block)
    curr = head
    while curr do
      block.call(curr)
      curr = curr.next_node
    end
  end

  def remove_first
    @head = @head&.next_node
  end
end

def ll(arr)
  head = nil

  arr.reverse.each do |value|
    head = LLNode.new(value, head)
  end

  head
end

def ll_add_value(head, value)
  ll_add_node(head, LLNode.new(value))
end

def ll_add_node(head, node)
  if head
    tail = head
    while tail.next_node do
      tail = tail.next_node
    end

    tail.next_node = node
    head
  else
    node
  end
end

def ll_to_array(head)
  res = []
  curr = head

  while curr do
    res << curr.value
    curr = curr.next_node
  end

  res
end

def ll_size(head)
  n = 0
  curr = head
  while curr do
    curr = curr.next_node
    n += 1
  end
  n
end

RSpec.describe 'linked list' do
  describe '#ll' do
    subject { ll([1, 2, 3, 4, 5]) }

    it { expect(ll_to_array(subject)).to eq [1, 2, 3, 4, 5] }
  end

  describe '#ll_add_value' do
    subject { ll_add_value(list, 4) }

    let(:list) { ll([1, 2, 3]) }

    it { expect(ll_to_array(subject)).to eq [1, 2, 3, 4] }
  end

  describe '#ll_size' do
    subject { ll_size(list) }

    let(:list) { ll([1, 2, 3]) }

    it { is_expected.to eq 3 }
  end
end
