package trees_and_graphs

import (
	. "github.com/holyketzer/ctci_v6/lib"
	. "github.com/holyketzer/ctci_v6/test_helper"
	"gotest.tools/assert"
	"testing"
)

func TestValidBst(t *testing.T) {
	for _, f := range []func(tree *BinaryTree) bool{ValidBstA} {
		name := GetFunctionName(f)

		// BST tree
		tree := ArrayToBstA([]int{1, 2, 3, 4, 5, 6, 7})
		assert.Equal(t, f(tree), true, name)

		// Not BST tree
		tree = ArrayToBstA([]int{1, 2, 3, 4, 5, 6, 7})
		tree.Root.Left.Left.Value = 5
		assert.Equal(t, f(tree), false, name)
	}
}
