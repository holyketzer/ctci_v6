module BstSequences
  def seq_build_bst(arr)
    root = nil

    arr.each do |v|
      if root
        append_value_to_bst(root, v)
      else
        root = BinaryTree::Node.new(v)
      end
    end

    BinaryTree.new(root)
  end

  def append_value_to_bst(curr, v)
    if v < curr.value
      if curr.left
        append_value_to_bst(curr.left, v)
      else
        curr.left = BinaryTree::Node.new(v)
      end
    else
      if curr.right
        append_value_to_bst(curr.right, v)
      else
        curr.right = BinaryTree::Node.new(v)
      end
    end
  end

  # All tree items are uniq
  # n - count of nodes
  # Time = (4^n) Mem = O(4^n)
  def bst_sequences_a(tree)
    res = []
    seq = [tree.root.value]
    next_nodes = append_next_nodes([], tree.root)
    generate_permutations(seq, next_nodes, res)
  end

  def generate_permutations(seq, next_nodes, res)
    if next_nodes.empty?
      res << seq
    else
      next_nodes.each_with_index do |node, i|
        sub_seq = seq + [node.value]
        sub_next = append_next_nodes(next_nodes, node, i)
        generate_permutations(sub_seq, sub_next, res)
      end
    end

    res
  end

  def append_next_nodes(next_nodes, curr_node, remove_index = nil)
    res = []

    next_nodes.each_with_index do |node, i|
      if i != remove_index
        res << node
      end
    end

    if curr_node.left
      res << curr_node.left
    end

    if curr_node.right
      res << curr_node.right
    end

    res
  end

  RSpec.describe 'bst_sequences' do
    include BstSequences

    describe 'seq_build_bst' do
      subject { seq_build_bst(arr) }

      context 'small balanced tree' do
        let(:arr) { [2, 1, 3] }

        it { expect(subject.to_s).to eq '((1) 2 (3))' }
      end

      context 'unbalanced tree' do
        let(:arr) { [5, 4, 3, 2, 1] }

        it { expect(subject.to_s).to eq '(((((1) 2) 3) 4) 5)' }
      end

      context 'some tree' do
        let(:arr) { [5, 4, 3, 6, 7] }

        it { expect(subject.to_s).to eq '(((3) 4) 5 (6 (7)))' }
      end
    end

    %i(a).each do |implementation|
      describe "#{implementation} case" do
        subject { send("bst_sequences_#{implementation}", tree) }

        let(:tree) { seq_build_bst(arr) }

        context '3-n tree' do
          let(:arr) { [2, 1, 3] }

          it do
            is_expected.to eq [
              [2, 1, 3],
              [2, 3, 1],
            ]
          end
        end

        context '4-n tree' do
          let(:arr) { [2, 1, 3, 4] }

          it do
            is_expected.to eq [
              [2, 1, 3, 4],
              [2, 3, 1, 4],
              [2, 3, 4, 1],
            ]
          end
        end

        context '5-n tree' do
          let(:arr) { [2, 1, 4, 3, 5] }

          it do
            is_expected.to eq [
              [2, 1, 4, 3, 5],
              [2, 1, 4, 5, 3],
              [2, 4, 1, 3, 5],
              [2, 4, 1, 5, 3],
              [2, 4, 3, 1, 5],
              [2, 4, 3, 5, 1],
              [2, 4, 5, 1, 3],
              [2, 4, 5, 3, 1]
            ]
          end
        end
      end
    end
  end
end
