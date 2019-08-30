# n - list size
# time = O(n), mem = O(1)
def kth_a(head, k)
  n = ll_size(head)

  res = nil
  curr = head
  i = 0

  while n - i >= k do
    res = curr.value
    curr = curr.next_node
    i += 1
  end

  res
end

# time = O(n), mem = O(n), recursive
def kth_b(head, k)
  n = ll_size(head)
  nth_recursuve(head, n - k)
end

def nth_recursuve(head, i)
  if i == 0 || head == nil
    head&.value
  else
    nth_recursuve(head.next_node, i - 1)
  end
end

# time = O(n), mem = O(1), fast and slow iterators
def kth_c(head, k)
  slow = head
  fast = head
  slow_counter = 0
  size = 0

  while fast do
    fast = fast.next_node
    size += 1

    if fast
      slow = slow.next_node
      fast = fast.next_node
      slow_counter += 1
      size += 1
    end
  end

  index = size - k

  if index < 0 || index > size
    nil
  elsif index > slow_counter
    while index != slow_counter do
      slow = slow.next_node
      slow_counter += 1
    end
    slow.value
  else
    i = 0
    curr = head
    while index != i  do
      curr = curr.next_node
      i += 1
    end
    curr.value
  end
end

RSpec.describe 'kth' do
  %i(a b c).each do |implementation|
    describe "#{implementation} case" do
      subject { send("kth_#{implementation}", list, k) }

      let(:list) { ll([1, 2, 3, 4, 5, 6, 7]) }

      context 'last one' do
        let(:k) { 1 }

        it { is_expected.to eq 7 }
      end

      context 'middle one' do
        let(:k) { 4 }

        it { is_expected.to eq 4 }
      end

      context 'first one' do
        let(:k) { 7 }

        it { is_expected.to eq 1 }
      end

      context 'out of range' do
        let(:k) { 8 }

        it { is_expected.to eq nil }
      end
    end
  end
end
