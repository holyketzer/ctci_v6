module TopologicalSort
  def solve_recursive(graph)
    vertices = get_all_vertices(graph)

    res = []

    vertices.keys.each do |vertex|
      step(vertex, vertices, graph, res)
    end

    res.reverse
  end

  def get_all_vertices(graph)
    vertices = {}

    graph.each do |vertex, children|
      vertices[vertex] = :white
      children.each { |v| vertices[v] = :white }
    end

    vertices
  end

  def step(vertex, vertices, graph, res)
    if vertices[vertex] == :gray
      raise ArgumentError, "unsortable graph"
    elsif vertices[vertex] == :white
      vertices[vertex] = :gray

      Array(graph[vertex]).each do |v|
        step(v, vertices, graph, res)
      end

      vertices[vertex] = :black
      res << vertex
    end
  end

  def solve_iterative(graph)
    # state of all vertices
    vertices = get_all_vertices(graph)
    # white - not visited
    # gray - in process
    # black - done

    res = []
    queue = [graph.first] # [[vertex, childs], [next_vertex, next_childs]],
    # when vertex is handled and ready to be marked black childred is empty

    vertices[queue[0]] = :gray

    while queue.size > 0 do
      vertex, children = *queue.last

      if children.size > 0
        children.each do |child|
          if vertices[child] == :white
            queue.push([child, Array(graph[child])])
            vertices[children] = :gray
          elsif vertices[child] == :gray
            raise ArgumentError, "unsortable graph"
          end
        end

        queue.last[1] = [] # remove children, they are handled
      else
        vertices[vertex] = :black
        res << vertex
        queue.pop
      end
    end

    res.reverse
  end

  RSpec.describe 'TopologicalSort' do
    include TopologicalSort

    %i(recursive iterative).each do |implementation|
      context "implementation #{implementation}" do
        subject { send("solve_#{implementation}", graph) }

        let(:graph) do
          {
            a: [:b, :c, :d, :e],
            b: [:d],
            c: [:d, :e],
            d: [:e],
          }
        end

        it { is_expected.to eq(%i[a b c d e]).or eq(%i[a c b d e]) }
      end
    end
  end
end
