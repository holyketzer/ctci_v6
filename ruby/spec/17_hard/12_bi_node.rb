module BiNode
  class Node
    attr_accessor :node1, :node2, :data

    def initialize(data, node1: nil, node2: nil)
      @data = data
      @node1 = node1
      @node2 = node2
    end

    def list_to_array
      res = []
      curr = self

      while curr do
        res << curr.data
        curr = curr.node2
      end

      res
    end

    def tree_to_array
      res = []

      if node1
        res += node1.tree_to_array
      end

      res << data

      if node2
        res += node2.tree_to_array
      end

      res
    end
  end

  def tree_to_list(root)
    tail = append_node_to_list(root)
    head = tail

    while head.node1 do
      head = head.node1
    end

    head
  end

  def append_node_to_list(node, tail = nil)
    if node.node1
      tail = append_node_to_list(node.node1, tail)
    end

    node.node1 = tail

    if tail
      tail.node2 = node
    end

    tail = node

    if node.node2
      tail = append_node_to_list(node.node2, tail)
    end

    tail
  end

  RSpec.describe 'BiNode' do
    include BiNode

    subject { tree_to_list(tree).list_to_array }

    let(:tree) do
      Node.new(
        3,
        node1: Node.new(
          1,
          node1: Node.new(0),
          node2: Node.new(2)
        ),
        node2: Node.new(4)
      )
    end

    before { expect(tree.tree_to_array).to eq [0, 1, 2, 3, 4] }

    it { expect(subject).to eq [0, 1, 2, 3, 4] }
  end
end
