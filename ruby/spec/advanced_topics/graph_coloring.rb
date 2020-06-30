module GraphColoring
  def solve(graph)
    graph.each_with_object({}) do |(node, edges), node_colors|
      node_colors[node] = min_available_color(node, edges, node_colors)
    end
  end

  def min_available_color(node, edges, node_colors)
    min = 1

    edges.map { |nn| node_colors[nn] }.compact.sort.each do |n_color|
      if min == n_color
        min += 1
      end
    end

    min
  end

  RSpec.describe 'GraphColoring' do
    include GraphColoring

    subject { solve(graph) }

    context 'simple graph' do
      let(:graph) do
        {
          a: %i(b c h),
          b: %i(a d),
          c: %i(a d),
          d: %i(b c e),
          e: %i(d f g),
          f: %i(e h),
          g: %i(e h),
          h: %i(f g a),
        }
      end

      it do
        expect(subject).to eq(a: 1, b: 2, c: 2, d: 1, e: 2, f: 1, g: 1, h: 2)
        expect(subject.values.uniq.size).to eq 2 # number of colors
      end
    end

    context 'more complex graph' do
      let(:graph) do
        {
          a: %i(b c h),
          b: %i(a d),
          c: %i(a d i),
          d: %i(b c e),
          e: %i(d f g),
          f: %i(e h),
          g: %i(e h i),
          h: %i(f g a),
          i: %i(c g),
        }
      end

      it do
        expect(subject).to eq(a: 1, b: 2, c: 2, d: 1, e: 2, f: 1, g: 1, h: 2, i: 3)
        expect(subject.values.uniq.size).to eq 3 # number of colors
      end
    end
  end
end
