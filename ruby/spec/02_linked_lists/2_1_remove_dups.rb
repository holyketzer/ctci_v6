# n - list size
# time = O(n), mem = O(n)
def remove_dups_b(list)
  s = Set.new
  curr = list

  while curr do
    s.add(curr.value)
    curr = curr.next_node
  end

  curr = list
  prev = nil

  while curr do
    if s.include?(curr.value)
      s.delete(curr.value)
      prev = curr
    else
      prev.next_node = curr.next_node
    end

    curr = curr.next_node
  end

  list
end

# time = O(n*log(n)), mem = O(n)
def remove_dups_c(list)
  head = sort_ll(list)
  curr = head

  while curr.next_node do
    if curr.value == curr.next_node.value
      curr.next_node = curr.next_node.next_node
    else
      curr = curr.next_node
    end
  end

  head
end

def sort_ll(head)
  if ll_size(head) < 2
    head
  else
    a, b = *halve_list(head)
    merge_sorted_ll(sort_ll(a), sort_ll(b))
  end
end

def halve_list(head)
  half = ll_size(head) / 2
  a = head
  curr = a
  a_size = 1

  while a_size < half
    curr = curr.next_node
    a_size += 1
  end

  b = curr.next_node
  curr.next_node = nil
  [a, b]
end

def merge_sorted_ll(a, b)
  head = nil

  if a.value < b.value
    head = a
    a = a.next_node
  else
    head = b
    b = b.next_node
  end

  curr = head

  while a || b do
    if a && b
      if a.value < b.value
        curr.next_node = a
        a = a.next_node
      else
        curr.next_node = b
        b = b.next_node
      end
    elsif a
      curr.next_node = a
      a = a.next_node
    else
      curr.next_node = b
      b = b.next_node
    end

    curr = curr.next_node
  end

  head
end

RSpec.describe 'remove_dups' do
  %i(b c).each do |implementation|
    describe "#{implementation} case" do
      subject { send("remove_dups_#{implementation}", list) }

      context 'couple of dups' do
        let(:list) { ll([1, 2, 3, 1, 3, 4]) }

        it { expect(ll_to_array(subject)).to eq [1, 2, 3, 4] }
      end

      context 'many dups' do
        let(:list) { ll([1, 1, 3, 1, 3, 4, 3]) }

        it { expect(ll_to_array(subject)).to eq [1, 3, 4] }
      end
    end
  end
end
