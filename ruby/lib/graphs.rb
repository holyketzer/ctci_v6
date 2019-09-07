class DirectedGraph
  class Node
    attr_accessor :value, :visited, :pointers

    def initialize(value, pointers = [])
      @value = value
      @visited = false
      @pointers = pointers
    end
  end

  attr_reader :nodes

  def initialize
    @nodes = []
  end

  def append(value, pointers = [])
    Node.new(value, pointers).tap do |node|
      @nodes << node
    end
  end
end
