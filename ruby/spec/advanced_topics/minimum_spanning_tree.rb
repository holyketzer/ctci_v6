module MinimumSpanningTree
  class Graph
    attr_reader :vertices
    attr_reader :edges

    def initialize(graph = {})
      @vertices = Set.new
      @edges = Hash.new { |hash, key| hash[key] = {} }

      graph.each do |from, edges|
        edges.each do |to, w|
          add_edge(from, to, w)
        end
      end
    end

    def add_edge(from, to, w)
      @vertices << from
      @vertices << to

      @edges[from][to] = w
      @edges[to][from] = w
    end

    def vertices_count
      @vertices.size
    end
  end

  # Prim's algorithm
  def solve(graph)
    mst = Graph.new

    initial_from = graph.vertices.first
    initial_to, w = *graph.edges[initial_from].min_by(&:last)

    mst.add_edge(initial_from, initial_to, w)

    while mst.vertices_count < graph.vertices_count do
      candidates = []

      mst.vertices.each do |from|
        graph.edges[from].each do |to, w|
          if !mst.vertices.include?(to)
            candidates << [w, from, to]
          end
        end
      end

      w, from, to = *candidates.min_by(&:first)
      mst.add_edge(from, to, w)
    end

    mst.edges
  end

  RSpec.describe 'MinimumSpanningTree' do
    include MinimumSpanningTree

    subject { solve(graph) }

    let(:graph) do
      Graph.new(
        a: { b: 5, c: 3, },
        b: { d: 2 },
        c: { d: 1 },
        d: { a: 1, g: 2, h: 1 },
        e: { a: 1, h: 4, i: 7 },
        f: { b: 3, g: 1 },
        g: { c: 3, i: 2 },
        h: { c: 2, f: 2, g: 2 },
      )
    end

    it do
      is_expected.to eq(
        a: { d: 1, e: 1 },
        b: { d: 2 },
        c: { d: 1 },
        d: { a: 1, b: 2, c: 1, g: 2, h: 1 },
        e: { a: 1 },
        f: { g: 1 },
        g: { d: 2, f: 1, i: 2 },
        h: { d: 1 },
        i: { g: 2 },
      )
    end
  end
end
