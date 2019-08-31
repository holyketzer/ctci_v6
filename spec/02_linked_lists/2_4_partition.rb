# time = O(n), mem = O(1)
def partition_b(head, x)
  l = head
  r = head.next_node

  while l.value >= x do
    swap_values(l, r)
    r = r.next_node
  end

  while r do
    if r.value < x
      l = l.next_node
      swap_values(l, r)
    end

    r = r.next_node
  end

  head
end

def swap_values(a, b)
  tmp = a.value
  a.value = b.value
  b.value = tmp
end

RSpec.describe 'partition' do
  %i(b).each do |implementation|
    describe "#{implementation} case" do
      subject { send("partition_#{implementation}", list, x) }

      let(:x) { 5 }

      def expect_ordered_partition(expected, actual, x)
        lower = expected.select { |i| i < x }.sort
        equal_and_greater = expected.select { |i| i >= x }.sort

        actual_lower = actual[0, lower.size].sort
        actual_equal_and_greater = actual[lower.size, equal_and_greater.size].sort

        expect(actual_lower).to eq lower
        expect(actual_equal_and_greater).to eq equal_and_greater
      end

      let(:expected) { [1, 2, 3, 5, 5, 8, 10] }

      context 'first < 5' do
        let(:list) { ll([3, 5, 8, 5, 10, 2, 1]) }

        it { expect_ordered_partition(expected, ll_to_array(subject), x) }
      end

      context 'first = 5' do
        let(:list) { ll([5, 3, 8, 5, 10, 2, 1]) }

        it { expect_ordered_partition(expected, ll_to_array(subject), x) }
      end

      context 'first > 5' do
        let(:list) { ll([8, 3, 5, 5, 10, 2, 1]) }

        it { expect_ordered_partition(expected, ll_to_array(subject), x) }
      end
    end
  end
end
