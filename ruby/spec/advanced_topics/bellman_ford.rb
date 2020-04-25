module BellmanFord
  MAX_INT = 1 << (0.size * 8 - 1)

  def solve(graph, start, target)
    distances = Hash.new { |hash, key| hash[key] = MAX_INT }
    distances[start] = 0
    best_way = {}

    vertices = get_vertices(graph)

    (1..vertices.size).each do |iteration|
      changes = false

      each_pair(graph) do |from, to, w|
        distance_from = distances[from]

        if distance_from < MAX_INT && distance_from + w < distances[to]
          distances[to] = distance_from + w
          best_way[to] = from

          if iteration == vertices.size
            raise ArgumentError, "graph has negative loop"
          else
            changes = true
          end
        end
      end

      if !changes
        break
      end
    end

    path = [target]
    vertex = target

    while vertex != start do
      vertex = best_way[vertex]
      path << vertex
    end

    [distances[target], path.reverse]
  end

  def each_pair(graph, &block)
    graph.each do |from, edges|
      edges.each do |to, w|
        block.call(from, to, w)
      end
    end
  end

  def get_vertices(graph)
    res = Set.new

    each_pair(graph) do |from, to, _|
      res << from
      res << to
    end

    res
  end

  RSpec.describe 'BellmanFord' do
    include BellmanFord

    subject { solve(graph, :a, :i) }

    context 'without negative loops' do
      let(:graph) do
        {
          a: { b: 5, c: 3, e: 2 },
          b: { d: 2, c: -4 },
          c: { d: 1 },
          d: { a: 1, g: 2, h: 1 },
          e: { a: 1, h: 4, i: 7 },
          f: { b: 3, g: 1 },
          g: { c: 3, i: 2 },
          h: { c: 2, f: 2, g: 2 },
        }
      end

      it { is_expected.to eq [6, %i(a b c d g i)] }
    end

    context 'with negative loop' do
      let(:graph) do
        {
          a: { b: 5, c: 3, e: 2 },
          b: { d: 2, c: -4 },
          c: { d: 1 },
          d: { a: 1, g: 2, h: 1 },
          e: { a: 1, h: 4, i: 7 },
          f: { b: 3, g: 1 },
          g: { c: 3, i: 2, a: -7 },
          h: { c: 2, f: 2, g: 2 },
        }
      end

      it { expect { subject }.to raise_error(ArgumentError, /graph has negative loop/) }
    end
  end
end
