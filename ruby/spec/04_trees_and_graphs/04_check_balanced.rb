require_relative './02_minimal_tree'

# n - size of array, k - depth
# Time = O(k*2^k) Mem = O(k)
def balanced_bt_b?(tree)
  balanced_from_node?(tree.root)
end

def balanced_from_node?(node)
  if node
    balanced = (depth(node.left) - depth(node.right)).abs <= 1
    balanced && balanced_from_node?(node.left) && balanced_from_node?(node.right)
  else
    true
  end
end

def depth(node)
  if node
    ld = depth(node.left)
    rd = depth(node.right)

    if ld > rd
      ld + 1
    else
      rd + 1
    end
  else
    0
  end
end

# Time = O(n) Mem = O(k)
def balanced_bt_a?(tree)
  root = tree.root
  balanced_left_and_right?(root.left, root.right)
end

def balanced_left_and_right?(l, r)
  if l == nil && r == nil
    true
  elsif l == nil
    r.left == nil && r.right == nil
  elsif r == nil
    l.left == nil && l.right == nil
  else
    balanced_left_and_right?(l.left, l.right) && balanced_left_and_right?(r.left, r.right)
  end
end

RSpec.describe 'balanced_bt' do
  %i(b a).each do |implementation|
    describe "#{implementation} case" do
      subject { send("balanced_bt_#{implementation}?", tree) }

      context 'perfect tree' do
        let(:tree) { array_to_bst_a([1, 2, 3, 4, 5, 6, 7]) }

        it { is_expected.to eq true }
      end

      context 'not perfect balanced tree' do
        let(:tree) { array_to_bst_a([1, 2, 3, 4, 5, 6, 7, 8]) }

        it { is_expected.to eq true }
      end

      context 'not balanced tree' do
        let(:tree) { array_to_bst_a([1, 2, 3, 4, 5, 6, 7]) }

        before do
          x = BinaryTree::Node.new(20)
          y = BinaryTree::Node.new(10, right: x)
          tree.root.right.right.right = y
        end

        it { is_expected.to eq false }
      end
    end
  end
end
