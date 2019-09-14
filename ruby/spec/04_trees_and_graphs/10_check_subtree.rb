require_relative './09_bst_sequences.rb'

# t1 - count of nodes in T1, t2 - count of nodes in T2, T1 much bigger that t2
# Time = O(t1*t2), Mem = O(1)
def is_subtree_a?(t1, t2)
  is_similar_trees?(t1.root.left, t2.root, t2.root) || is_similar_trees?(t1.root.right, t2.root, t2.root)
end

def is_similar_trees?(node1, node2, tree2_root)
  if (node1 == nil && node2 == nil)
    return true
  elsif (node1 != nil && node2 != nil && node1.value == node2.value)
    if is_similar_trees?(node1.left, node2.left, tree2_root) && is_similar_trees?(node1.right, node2.right, tree2_root)
      return true
    end
  elsif node1
    if is_similar_trees?(node1.left, tree2_root, tree2_root) || is_similar_trees?(node1.right, tree2_root, tree2_root)
      return true
    end
  end

  false
end

RSpec.describe 'is_subtree' do
  %i(a).each do |implementation|
    describe "#{implementation} case" do
      subject { send("is_subtree_#{implementation}?", tree1, tree2) }

      let(:tree2) { seq_build_bst([5, 3, 7]) }

      context 'subtree' do
        let(:tree1) { seq_build_bst([1, 0, 5, 3, 7]) }

        it { is_expected.to eq true }
      end

      context 'not a subtree but with similat sequence' do
        let(:tree1) { seq_build_bst([2, 5, 3, 7, 8]) }

        it { is_expected.to eq false }
      end

      context 'same tree' do
        let(:tree1) { seq_build_bst([5, 3, 7]) }

        it { is_expected.to eq false }
      end
    end
  end
end
