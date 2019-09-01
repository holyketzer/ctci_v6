# time = O(n), mem = O(1)
def loop_b?(head)
  slow = head
  fast = head

  while fast do
    fast = fast.next_node

    if slow == fast
      return true
    end

    if fast
      fast = fast.next_node

      if slow == fast
        return true
      end

      slow = slow.next_node

      if slow == fast
        return true
      end
    end
  end

  false
end

RSpec.describe 'loop' do
  %i(b).each do |implementation|
    describe "#{implementation} case" do
      subject { send("loop_#{implementation}?", list) }

      context 'no loop' do
        let(:list) { ll([1, 2, 3, 4, 5]) }

        it { is_expected.to eq false }
      end

      context 'loop' do
        let(:head) { ll([1, 2, 3, 4, 5]) }
        let(:list) { ll_add_node(head, head.next_node.next_node.next_node) }

        it { is_expected.to eq true }
      end
    end
  end
end
