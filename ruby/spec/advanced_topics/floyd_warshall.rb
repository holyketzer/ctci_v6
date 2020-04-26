module FloydWarshall
  MAX_INT = 1 << (0.size * 8 - 1)

  def solve(graph, start, target)
    weights = Hash.new { |hash, key| hash[key] = Hash.new { |h, k| h[k] = MAX_INT } }
    best_way = Hash.new { |hash, key| hash[key] = {} }

    each_pair(graph) do |from, to, w|
      weights[from][to] = w
      best_way[from][to] = from
    end

    vertices = get_vertices(graph)

    vertices.each do |k|
      vertices.each do |i|
        vertices.each do |j|
          ij = weights[i][j]

          if weights[i][k] != MAX_INT && weights[k][j] != MAX_INT
            if weights[i][j] > weights[i][k] + weights[k][j]
              weights[i][j] = weights[i][k] + weights[k][j]
              best_way[i][j] = best_way[k][j]
            end
          end
        end
      end
    end

    if weights[start][target] != MAX_INT
      if has_negative_loops?(weights, vertices)
        raise ArgumentError, "graph has negative loop"
      else
        [weights[start][target], build_path(best_way, start, target)]
      end
    else
      nil
    end
  end

  def has_negative_loops?(weights, vertices)
    vertices.any? { |v| weights[v][v] < 0 }
  end

  def build_path(best_way, from, to)
    res = [to]

    while from != best_way[from][to] do
      to = best_way[from][to]
      res << to
    end

    res << from

    res.reverse
  end

  def get_vertices(graph)
    res = Set.new

    each_pair(graph) do |from, to, _|
      res << from
      res << to
    end

    res
  end

  def each_pair(graph, &block)
    graph.each do |from, edges|
      edges.each do |to, w|
        block.call(from, to, w)
      end
    end
  end

  RSpec.describe 'FloydWarshall' do
    include FloydWarshall

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
