require_relative './02_minimal_tree'

# n - count of nodes, k - depth
# Time - O(k), Mem = O(1)
def next_node_a(node)
  find_next_node(node, node.value)
end

def find_next_node(curr, value)
  if curr.value == value + 1
    return curr
  end

  if left = curr.left
    if left.value > value
      return find_next_node(left, value)
    end
  end

  if right = curr.right
    if right.value > value
      return find_next_node(right, value)
    end
  end

  if curr.value > value
    return curr
  end

  if parent = curr.parent
    if left_subtree?(curr)
      return parent
    end

    return find_next_node(parent, value)
  end
end

def left_subtree?(node)
  node.parent&.left == node
end

def right?(node)
  node.parent&.right == node
end

RSpec.describe 'next_node' do
  %i(a).each do |implementation|
    describe "#{implementation} case" do
      subject { send("next_node_#{implementation}", node) }

      context 'BST tree without spaces' do
        let(:tree) { array_to_bst_a([1, 2, 3, 4, 5, 6, 7]) }

        let(:first_node) { tree.root.left.left }

        before { expect(first_node.value).to eq 1 }

        it do
          expect((node = next_node_a(first_node)).value).to eq 2
          expect((node = next_node_a(node)).value).to eq 3
          expect((node = next_node_a(node)).value).to eq 4
          expect((node = next_node_a(node)).value).to eq 5
          expect((node = next_node_a(node)).value).to eq 6
          expect((node = next_node_a(node)).value).to eq 7
          expect(next_node_a(node)).to eq nil
        end
      end

      context 'BST tree with spaces' do
        let(:tree) { array_to_bst_a([1, 3, 5, 7, 9, 11, 12, 15, 20]) }
        #             9
        #       5           15
        #    3    7      12    20
        # 1           11

        let(:first_node) { tree.root.left.left.left }

        before { expect(first_node.value).to eq 1 }

        it do
          expect((node = next_node_a(first_node)).value).to eq 3
          expect((node = next_node_a(node)).value).to eq 5
          expect((node = next_node_a(node)).value).to eq 7
          expect((node = next_node_a(node)).value).to eq 9
          expect((node = next_node_a(node)).value).to eq 11
          expect((node = next_node_a(node)).value).to eq 12
          expect((node = next_node_a(node)).value).to eq 15
          expect((node = next_node_a(node)).value).to eq 20
          expect(next_node_a(node)).to eq nil
        end
      end
    end
  end
end
