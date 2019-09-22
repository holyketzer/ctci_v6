package trees_and_graphs

import (
	. "github.com/holyketzer/ctci_v6/lib"
	. "github.com/holyketzer/ctci_v6/test_helper"
	"gotest.tools/assert"
	"testing"
)

func TestHasRoute(t *testing.T) {
	for _, ff := range []func(a *DGNode, b *DGNode) bool{HasRouteA} {
		name := GetFunctionName(ff)

		// Graph without cycles
		//      C------>D
		//      |      /|\
		//      |     / | \
		//      ˅    ˅  ˅  ˅
		// A <- B    E  F  G
		graph := NewDirectedGraph()
		a := graph.Append(1, []*DGNode{})
		b := graph.Append(2, []*DGNode{a})
		e := graph.Append(5, []*DGNode{})
		f := graph.Append(6, []*DGNode{})
		g := graph.Append(7, []*DGNode{})
		d := graph.Append(4, []*DGNode{e, f, g})
		c := graph.Append(3, []*DGNode{b, d})

		// Route exist
		assert.Equal(t, ff(c, g), true, name) // Direct order
		assert.Equal(t, ff(g, c), true, name) // Reverse order

		// Route not exist
		assert.Equal(t, ff(b, e), false, name) // Direct order
		assert.Equal(t, ff(e, b), false, name) // Reverse order

		// Graph with cycles
		//      C---------->D
		//      |^         /|\
		//      | \       / | \
		//      ˅  \     ˅  ˅  ˅
		// A <- B   X <- E  F  G
		x := graph.Append(8, []*DGNode{c})
		e.Pointers = append(e.Pointers, x)

		// Route exist
		assert.Equal(t, ff(d, e), true, name) // Direct order
		assert.Equal(t, ff(e, d), true, name) // Reverse order

		// Route not exist
		assert.Equal(t, ff(a, g), false, name) // Direct order
		assert.Equal(t, ff(g, a), false, name) // Reverse order
	}
}
