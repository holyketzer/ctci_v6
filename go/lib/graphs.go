package lib

type DGNode struct {
	Value    int
	Visited  bool
	Pointers []*DGNode
}

type DirectedGraph struct {
	Nodes []*DGNode
}

func NewDirectedGraph() *DirectedGraph {
	return &DirectedGraph{
		Nodes: make([]*DGNode, 0),
	}
}

func (g *DirectedGraph) Append(value int, pointers []*DGNode) *DGNode {
	node := &DGNode{
		Value:    value,
		Pointers: pointers,
	}
	g.Nodes = append(g.Nodes, node)
	return node
}
