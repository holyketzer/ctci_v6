# n - count ofv nodes
# Time = O(n), Mem = O(1)
def has_route_a?(a, b)
  res = has_route_from_to?(a, b)
  reset_visited(a)

  if res
    return true
  end

  res = has_route_from_to?(b, a)
  reset_visited(b)
  res
end

def has_route_from_to?(a, b)
  queue = [a]

  while queue.any? do
    n = queue.shift

    if n == b
      return true
    else
      n.pointers.each do |node|
        if !node.visited
          queue.push(node)
        end
      end

      n.visited = true
    end
  end

  false
end

def reset_visited(node)
  queue = [node]

  while queue.any? do
    n = queue.shift

    n.pointers.each do |node|
      if node.visited
        queue << node
      end
    end

    n.visited = false
  end
end

RSpec.describe 'has_route' do
  %i(a).each do |implementation|
    describe "#{implementation} case" do
      subject { send("has_route_#{implementation}?", n1, n2) }

      #      C------>D
      #      |      /|\
      #      |     / | \
      #      ˅    ˅  ˅  ˅
      # A <- B    E  F  G
      let(:graph) { DirectedGraph.new }

      let(:a) { graph.append(1) }
      let(:b) { graph.append(2, [a]) }
      let(:e) { graph.append(5) }
      let(:f) { graph.append(6) }
      let(:g) { graph.append(7) }
      let(:d) { graph.append(4, [e, f, g]) }
      let(:c) { graph.append(3, [b, d]) }

      context 'graph without cycles' do
        context 'route exist' do
          context 'direct order' do
            let(:n1) { c }
            let(:n2) { g }

            it { is_expected.to eq true }
          end

          context 'reversed order' do
            let(:n1) { g }
            let(:n2) { c }

            it { is_expected.to eq true }
          end
        end

        context 'route not exist' do
          context 'direct order' do
            let(:n1) { b }
            let(:n2) { e }

            it { is_expected.to eq false }
          end

          context 'reversed order' do
            let(:n1) { e }
            let(:n2) { b }

            it { is_expected.to eq false }
          end
        end
      end

      context 'graph with cycles' do
        #      C---------->D
        #      |^         /|\
        #      | \       / | \
        #      ˅  \     ˅  ˅  ˅
        # A <- B   X <- E  F  G
        let(:x) { graph.append(8, [c]) }

        before { e.pointers << x }

        context 'route exist' do
          context 'direct order' do
            let(:n1) { d }
            let(:n2) { e }

            it { is_expected.to eq true }
          end

          context 'reversed order' do
            let(:n1) { e }
            let(:n2) { d }

            it { is_expected.to eq true }
          end
        end

        context 'route not exist' do
          context 'direct order' do
            let(:n1) { a }
            let(:n2) { g }

            it { is_expected.to eq false }
          end

          context 'reversed order' do
            let(:n1) { g }
            let(:n2) { a }

            it { is_expected.to eq false }
          end
        end
      end
    end
  end
end
