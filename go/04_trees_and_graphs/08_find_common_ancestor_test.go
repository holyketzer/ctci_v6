package trees_and_graphs

import (
	. "github.com/holyketzer/ctci_v6/lib"
	. "github.com/holyketzer/ctci_v6/test_helper"
	"gotest.tools/assert"
	"testing"
)

func TestFindCommonAncestor(t *testing.T) {
	for _, f := range []func(*BTNode, *BTNode) *BTNode{FindCommonAncestorB} {
		name := GetFunctionName(f)

		// another complete tree
		//          5
		//     3        8
		//   2   4    7   9
		// 1        6
		tree := ArrayToBstA([]int{1, 2, 3, 4, 5, 6, 7, 8, 9})

		// root node shared
		a := tree.Root.Left.Left.Left // 1
		b := tree.Root.Right.Right    // 9

		assert.Equal(t, a.Value, 1)
		assert.Equal(t, b.Value, 9)
		assert.Equal(t, f(a, b).Value, 5, name)

		// some sub node shared
		a = tree.Root.Right.Left.Left // 6
		b = tree.Root.Right.Right     // 9

		assert.Equal(t, a.Value, 6)
		assert.Equal(t, b.Value, 9)
		assert.Equal(t, f(a, b).Value, 8, name)

		// the same node
		a = tree.Root // 5
		b = tree.Root // 5

		assert.Equal(t, f(a, b).Value, 5, name)

		// no shared nodes
		a = tree.Root.Left.Left
		anotherTree := ArrayToBstA([]int{1, 2, 3, 4, 5, 6, 7})
		b = anotherTree.Root.Left.Left

		assert.Equal(t, f(a, b) == nil, true, name)
	}
}
