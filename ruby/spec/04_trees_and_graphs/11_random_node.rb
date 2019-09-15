class RandomTree
  class Node
    attr_accessor :value, :parent, :count, :left, :right

    def initialize(value, parent = nil)
      @value = value
      @parent = parent
      @count = 1
    end

    def itself_count
      count - (left&.count || 0) - (right&.count || 0)
    end

    def to_s
      res = ''

      if left
        res += '(' + left.to_s + ') '
      end

      res += "#{value}[#{itself_count}]"

      if right
        res += ' (' + right.to_s + ')'
      end

      res
    end
  end

  attr_accessor :root

  def initialize(root = nil)
    @root = root
  end

  def count
    root&.count || 0
  end

  # Time = O(k), Mem = O(k)
  def insert(value)
    if @root == nil
      @root = Node.new(value)
    else
      append_value(root, value)
    end
  end

  def append_value(node, value)
    if node.value == value
      node.count += 1
    elsif node.value > value
      node.count += 1

      if node.left
        append_value(node.left, value)
      else
        node.left = Node.new(value, node)
      end
    else
      node.count += 1

      if node.right
        append_value(node.right, value)
      else
        node.right = Node.new(value, node)
      end
    end
  end

  # Time = O(k), Mem = O(1)
  def find(value)
    curr = root

    while curr do
      if curr.value == value
        return curr
      else
        curr = curr.value > value ? curr.left : curr.right
      end
    end
  end

  def replace_node(node, new_node)
    if (parent = node.parent)
      if parent.left == node
        parent.left = new_node
      else
        parent.right = new_node
      end

      if new_node
        new_node.parent = parent
      end
    end

    if node == root
      @root = new_node
    end
  end

  # Time = O(k), Mem = O(k)
  def delete(node)
    node.count -= 1

    if node.itself_count > 0
      dec_count_in_parents(node.parent)
    elsif node.left == nil && node.right == nil
      replace_node(node, nil)
      dec_count_in_parents(node.parent)
    elsif (l = node.left) && l.right == nil
      if (l.right = node.right)
        l.count += node.right.count
      end

      replace_node(node, l)
      dec_count_in_parents(node.parent)
    elsif (r = node.right) && r.left == nil
      if (r.left = node.left)
        r.count += node.left.count
      end

      replace_node(node, r)
      dec_count_in_parents(node.parent)
    elsif (l = node.left)
      lr = l.right
      node.value = lr.value
      node.count += 1
      delete(lr)
    elsif (r = node.right)
      rl = right.left
      node.value = rl.value
      node.count += 1
      delete(rl)
    else
      raise ArgumentError, 'unexpected case'
    end
  end

  def dec_count_in_parents(parent)
    while parent do
      parent.count -= 1
      parent = parent.parent
    end
  end

  def to_s
    "(#{root.to_s})"
  end

  # Time = O(k), Mem = O(k)
  def get_random_node
    if root
      get_node_by_index(rand(root.count))
    end
  end

  def get_node_by_index(i)
    get_node_by_index_from(root, i)
  end

  # Order: left -> curr -> right, indexing: 0..n-1
  def get_node_by_index_from(node, i)
    if node
      lcount = node.left&.count || 0

      if i - lcount < 0
        get_node_by_index_from(node.left, i)
      elsif i - lcount < node.itself_count
        node
      else
        get_node_by_index_from(node.right, i - lcount - node.itself_count)
      end
    end
  end
end

RSpec.describe RandomTree do
  let(:tree) { described_class.new }

  before do
    #        4
    #      /  \
    #     2    6
    #    / \    \
    #  1(2) 3    8
    [4, 2, 1, 3, 6, 1, 8].each do |value|
      tree.insert(value)
    end

    expect(tree.to_s).to eq '(((1[2]) 2[1] (3[1])) 4[1] (6[1] (8[1])))'
  end

  describe 'insert-find-delete' do
    let(:one) { tree.find(1) }
    let(:three) { tree.find(3) }
    let(:four) { tree.find(4) }
    let(:five) { tree.find(5) }
    let(:six) { tree.find(6) }

    it 'should find' do
      expect(one).to be_a (described_class::Node)
      expect(one.value).to eq 1
      expect(one.count).to eq 2

      expect(five).to eq nil
    end

    it 'should delete leaf' do
      expect { tree.delete(three) }.to change { tree.count }.by(-1)
      expect(tree.find(3)).to eq nil
    end

    it 'should decrease count if > 1' do
      expect { tree.delete(one) }.to change { tree.count }.by(-1)
      expect(tree.find(1)).to be_a described_class::Node
      expect(tree.find(1).count).to eq 1
    end

    it 'should pull branch' do
      expect { tree.delete(six) }.to change { tree.count }.by(-1)
      expect(tree.find(6)).to eq nil
    end

    it 'should pull branch (root case)' do
      expect { tree.delete(four) }.to change { tree.count }.by(-1)
      expect(tree.find(4)).to eq nil
    end

    it 'should rotate branch' do
      tree.insert(5)
      expect { tree.delete(four) }.to change { tree.count }.by(-1)
      expect(tree.find(4)).to eq nil
    end
  end

  describe '#get_node_by_index' do
    it do
      expect(tree.get_node_by_index(-1)).to eq nil
      expect(tree.get_node_by_index(0).value).to eq 1
      expect(tree.get_node_by_index(1).value).to eq 1
      expect(tree.get_node_by_index(2).value).to eq 2
      expect(tree.get_node_by_index(3).value).to eq 3
      expect(tree.get_node_by_index(4).value).to eq 4
      expect(tree.get_node_by_index(5).value).to eq 6
      expect(tree.get_node_by_index(6).value).to eq 8
      expect(tree.get_node_by_index(7)).to eq nil
    end
  end

  describe '#get_random_node' do
    it do
      values_count = Hash.new { |hash, key| hash[key] = 0 }

      # This is a stupid but funny: probability and Law of large numbers based test
      1000.times do
        node = tree.get_random_node
        expect(node).to be_a described_class::Node
        values_count[node.value] += 1
      end

      values_count.each do |k, v|
        if k != 1
          # 1 - is presented in tree twice, all another values only once,
          # so it should be generated with x2 probability comparing to other values
          expect(v).to be < values_count[1]
          expect((values_count[1]/v.to_f).round).to be >= 2
        end
      end
    end
  end
end
