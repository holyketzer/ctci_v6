# time = O(n), mem = O(1)
def intersection_a?(a, b)
  a_tail = a
  b_tail = b

  while a_tail.next_node do
    a_tail = a_tail.next_node
  end

  while b_tail.next_node do
    b_tail = b_tail.next_node
  end

  a_tail == b_tail
end

RSpec.describe 'intersection' do
  %i(a).each do |implementation|
    describe "#{implementation} case" do
      subject { send("intersection_#{implementation}?", a, b) }

      context 'without intersection' do
        let(:a) { ll([1, 2, 3, 4, 5]) }
        let(:b) { ll([1, 2, 3, 4, 5]) }

        it { is_expected.to eq false }
      end

      context 'with intersection' do
        let(:a) { ll([1, 2, 3, 4, 5]) }
        let(:b_head) { ll([7, 8, 9]) }
        let(:b) { ll_add_node(b_head, a.next_node.next_node.next_node) }

        it { is_expected.to eq true }
      end
    end
  end
end
