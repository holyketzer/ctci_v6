# n - count of projects
# Time = O(n^2) Mem = O(n)
def build_order_a(projects, deps)
  isolated = {}

  nodes = projects.each_with_object({}) do |x, res|
    res[x] = DirectedGraph::Node.new(x)
    isolated[x] = true
  end

  deps.each do |(from, to)|
    nodes[from].pointers << nodes[to]
    isolated[from] = false
    isolated[to] = false
  end

  nodes.each do |name, node|
    if res = has_route_to_all_nodes?(node, nodes, isolated)
      if no_cyces?(node)
        return res
      end
    end
  end

  nil
end

def has_route_to_all_nodes?(node, nodes, isolated)
  covered = isolated.select { |_, i| i == true }.to_h
  q = [node]
  path = covered.keys.sort

  while !q.empty? do
    curr = q.shift
    covered[curr.value] = true
    path << curr.value

    curr.pointers.each do |node|
      if !covered[node.value]
        q << node
        covered[node.value] = true
      end
    end
  end

  if covered.size == nodes.size
    return path
  end
end

def no_cyces?(node)
  covered_edges = Hash.new { |hash, key| hash[key] = {} } # to -> from
  q = [node]

  while !q.empty? do
    curr = q.shift

    curr.pointers.each do |node|
      if covered_edges[node.value][curr.value]
        return false
      elsif covered_edges[node.value].empty?
        q << node
      end

      covered_edges[node.value][curr.value] = true
    end
  end

  true
end

RSpec.describe 'build_order' do
  %i(a).each do |implementation|
    describe "#{implementation} case" do
      subject { send("build_order_#{implementation}", projects, deps) }

      let(:projects) { %i(a b c d e f) }

      context 'solvable deps' do
        # [:a, :d] -> means :d depends on :a
        let(:deps) { [[:a, :d], [:f, :b], [:b, :d], [:f, :a], [:d, :c]] }

        it { is_expected.to eq [:e, :f, :b, :a, :d, :c] }
      end

      context 'unsolvable deps' do
        let(:deps) { [[:a, :d], [:f, :b], [:b, :d], [:f, :a], [:d, :c], [:c, :f]] }

        it { is_expected.to eq nil }
      end
    end
  end
end
