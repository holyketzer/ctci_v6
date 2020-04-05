require 'rb_heap'

module DijkstrasAlgorithm
  MAX_INT = 1 << (0.size * 8 - 1)

  def solve(graph, from, to)
    visited = {}
    path = {}

    shortest_path = Hash.new { |hash, key| hash[key] = MAX_INT }
    shortest_path[from] = 0

    shortest_path_heap = Heap.new { |a, b| shortest_path[a] < shortest_path[b] } # min heap by first item
    shortest_path_heap << from

    while shortest_path_heap.size > 0
      p shortest_path
      curr_node = shortest_path_heap.pop
      weight = shortest_path[curr_node]

      graph.fetch(curr_node, {}).each do |next_node, next_weigth|
        if !visited[next_node]
          new_weigth = weight + next_weigth

          if (not_in_queue = shortest_path[next_node] == MAX_INT)
            shortest_path_heap << next_node
          end

          if not_in_queue || new_weigth < shortest_path[next_node]
            shortest_path[next_node] = new_weigth
            path[next_node] = curr_node
          end
        end
      end

      visited[curr_node] = true
    end

    if shortest_path[to] != MAX_INT
      [shortest_path[to], build_path(path, from, to)]
    else
      nil
    end
  end

  def build_path(path, from, to)
    res = [to]
    curr = to

    while curr != from && curr != nil do
      curr = path[curr]
      res << curr
    end

    res.reverse
  end

  RSpec.describe 'DijkstrasAlgorithm' do
    include DijkstrasAlgorithm

    subject { solve(graph, :a, :i) }

    let(:graph) do
      {
        a: { b: 5, c: 3, e: 2 },
        b: { d: 2 },
        c: { d: 1 },
        d: { a: 1, g: 2, h: 1 },
        e: { a: 1, h: 4, i: 7 },
        f: { b: 3, g: 1 },
        g: { c: 3, i: 2 },
        h: { c: 2, f: 2, g: 2 },
      }
    end

    it { is_expected.to eq [8, %i(a c d g i)] }
  end
end
