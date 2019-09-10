# n - size of array
# Time = O(n) Mem = O(n)
def array_to_bst_a(arr)
  BinaryTree.new(create_bst(arr, 0, arr.size - 1))
end

def create_bst(arr, l, r, parent: nil)
  if l == r
    BinaryTree::Node.new(arr[l], parent: parent)
  else
    m = (l + r) / 2

    if (l + r) % 2 != 0
      m += 1
    end

    BinaryTree::Node.new(arr[m], parent: parent).tap do |node|
      if l != m
        node.left = create_bst(arr, l, m - 1, parent: node)
      end

      if r != m
        node.right = create_bst(arr, m + 1, r, parent: node)
      end
    end
  end
end

RSpec.describe 'array_to_bst' do
  %i(a).each do |implementation|
    describe "#{implementation} case" do
      subject { send("array_to_bst_#{implementation}", arr.sort) }

      context 'perfect tree' do
        let(:arr) { [1, 2, 3, 4, 5, 6, 7] }

        it do
          expect(subject.to_s).to eq '(((1) 2 (3)) 4 ((5) 6 (7)))'
          expect(subject.depth).to eq 3
        end
      end

      context 'complete tree' do
        let(:arr) { [1, 2, 3, 4, 5, 6] }

        it do
          expect(subject.to_s).to eq '(((1) 2 (3)) 4 ((5) 6))'
          expect(subject.depth).to eq 3
        end
      end

      context 'another complete tree' do
        let(:arr) { [1, 2, 3, 4, 5, 6, 7, 8, 9] }

        it do
          expect(subject.to_s).to eq '((((1) 2) 3 (4)) 5 (((6) 7) 8 (9)))'
          expect(subject.depth).to eq 4
        end
      end
    end
  end
end
