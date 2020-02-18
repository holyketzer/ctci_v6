require_relative '02_minimal_tree'

# n - count of nodes, k - depth
# Time = O(k) Mem = O(1)
def find_common_ancestor_b(a, b)
  a_depth = depth_to_up(a)
  b_depth = depth_to_up(b)

  while a_depth > b_depth do
    a = a.parent
    a_depth -= 1
  end

  while b_depth > a_depth do
    b = b.parent
    b_depth -= 1
  end

  while a && b do
    if a == b
      return a
    else
      a = a.parent
      b = b.parent
    end
  end

  nil
end

def depth_to_up(node)
  res = 0

  while node do
    node = node.parent
    res += 1
  end

  res
end

RSpec.describe 'find_common_ancestor' do
  include MinimalTree

  %i(b).each do |implementation|
    describe "#{implementation} case" do
      subject { send("find_common_ancestor_#{implementation}", a, b) }

      context 'another complete tree' do
        #          5
        #     3        8
        #   2   4    7   9
        # 1        6
        let(:tree) { array_to_bst_a([1, 2, 3, 4, 5, 6, 7, 8, 9]) }

        context 'root node shared' do
          let(:a) { tree.root.left.left.left } # 1
          let(:b) { tree.root.right.right } # 9

          before do
            expect(a.value).to eq 1
            expect(b.value).to eq 9
          end

          it { expect(subject.value).to eq 5 }
        end

        context 'some sub node shared' do
          let(:a) { tree.root.right.left.left } # 6
          let(:b) { tree.root.right.right } # 9

          before do
            expect(a.value).to eq 6
            expect(b.value).to eq 9
          end

          it { expect(subject.value).to eq 8 }
        end

        context 'the same node' do
          let(:a) { tree.root } # 5
          let(:b) { tree.root } # 5

          it { expect(subject.value).to eq 5 }
        end

        context 'no shared nodes' do
          let(:a) { tree.root.left.left }
          let(:another_tree) { array_to_bst_a([1, 2, 3, 4, 5, 6, 7]) }
          let(:b) { another_tree.root.left.left }

          it { expect(subject).to eq nil }
        end
      end
    end
  end
end
