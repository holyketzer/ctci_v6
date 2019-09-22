package trees_and_graphs

import (
	. "github.com/holyketzer/ctci_v6/lib"
	. "github.com/holyketzer/ctci_v6/test_helper"
	"gotest.tools/assert"
	"testing"
)

func TestBalancedBt(t *testing.T) {
	for _, f := range []func(tree *BinaryTree) bool{BalancedBtA, BalancedBtB} {
		name := GetFunctionName(f)

		// Perfect tree
		tree := ArrayToBstA([]int{1, 2, 3, 4, 5, 6, 7})
		assert.Equal(t, f(tree), true, name)

		// Not perfect balanced tree
		tree = ArrayToBstA([]int{1, 2, 3, 4, 5, 6, 7, 8})
		assert.Equal(t, f(tree), true, name)

		// Not balanced tree
		tree = ArrayToBstA([]int{1, 2, 3, 4, 5, 6, 7})
		x := &BTNode{Value: 20}
		y := &BTNode{Value: 10, Right: x}
		tree.Root.Right.Right.Right = y

		assert.Equal(t, f(tree), false, name)
	}
}
