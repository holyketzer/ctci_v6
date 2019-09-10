require_relative './02_minimal_tree'

# n - count of nodes
# Time - O(n), Mem = O(1)
def valid_bst_a?(tree)
  valid_bst_node?(tree.root)
end

def valid_bst_node?(node)
  if left = node.left
    if left.value >= node.value || !valid_bst_node?(left)
      return false
    end
  end

  if right = node.right
    if right.value <= node.value || !valid_bst_node?(right)
      return false
    end
  end

  return true
end

RSpec.describe 'valid_bst' do
  %i(a).each do |implementation|
    describe "#{implementation} case" do
      subject { send("valid_bst_#{implementation}?", tree) }

      context 'BST tree' do
        let(:tree) { array_to_bst_a([1, 2, 3, 4, 5, 6, 7]) }

        it { is_expected.to eq true }
      end

      context 'not BST tree' do
        let(:tree) { array_to_bst_a([1, 2, 3, 4, 5, 6, 7]) }

        before do
          tree.root.left.left.value = 5
        end

        it { is_expected.to eq false }
      end
    end
  end
end
