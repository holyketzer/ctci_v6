# time = O(1), mem = O(1)
def delete_middle_a(node)
  node.value = node.next_node.value
  node.next_node = node.next_node.next_node
end

RSpec.describe 'delete_middle' do
  %i(a).each do |implementation|
    describe "#{implementation} case" do
      subject { send("delete_middle_#{implementation}", node) }

      let(:list) { ll([1, 2, 3, 4, 5]) }
      let(:node) { list.next_node.next_node }

      it do
        subject
        expect(ll_to_array(list)).to eq [1, 2, 4, 5]
      end
    end
  end
end
