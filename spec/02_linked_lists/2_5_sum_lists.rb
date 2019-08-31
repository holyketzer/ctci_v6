# time = O(n), mem = O(n)
def sum_lists_reversed(a, b)
  res_head = nil
  res = nil
  shift = 0

  while a || b do
    v = shift

    if a
      v += a.value
    end

    if b
      v += b.value
    end

    shift = v / 10
    node = LLNode.new(v % 10)

    if res
      res.next_node = node
    else
      res_head = node
    end

    res = node

    a = a&.next_node
    b = b&.next_node
  end

  res_head
end

# time = O(n), mem = O(n)
def sum_lists_direct(a, b)
  sum = ll_to_i(a) + ll_to_i(b)

  res = nil

  while sum > 0 do
    res = LLNode.new(sum % 10, res)
    sum = sum / 10
  end

  res
end

def ll_to_i(head, base = 10)
  res = 0

  while head do
    res = res * base + head.value
    head = head.next_node
  end

  res
end

RSpec.describe 'sum_lists' do
  describe 'sum_lists_reversed' do
    subject { sum_lists_reversed(a, b) }

    context 'equal size' do
      let(:a) { ll([7, 1, 6]) }
      let(:b) { ll([5, 9, 2]) }

      it { expect(ll_to_array(subject)).to eq [2, 1, 9] }
    end

    context 'diffrenet size' do
      let(:a) { ll([7, 1, 6, 8]) }
      let(:b) { ll([9, 2]) }

      it { expect(ll_to_array(subject)).to eq [6, 4, 6, 8] }
    end
  end

  describe 'sum_lists_direct' do
    subject { sum_lists_direct(a, b) }

    context 'equal size' do
      let(:a) { ll([6, 1, 7]) }
      let(:b) { ll([2, 9, 5]) }

      it { expect(ll_to_array(subject)).to eq [9, 1, 2] }
    end

    context 'diffrenet size' do
      let(:a) { ll([8, 6, 1, 7]) }
      let(:b) { ll([2, 9]) }

      it { expect(ll_to_array(subject)).to eq [8, 6, 4, 6] }
    end
  end
end
