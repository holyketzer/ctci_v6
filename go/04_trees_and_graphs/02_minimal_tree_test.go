package trees_and_graphs

import (
	. "github.com/holyketzer/ctci_v6/lib"
	. "github.com/holyketzer/ctci_v6/test_helper"
	"gotest.tools/assert"
	"testing"
)

func TestArrayToBst(t *testing.T) {
	for _, f := range []func(arr []int) *BinaryTree{ArrayToBstA} {
		name := GetFunctionName(f)

		// Perfect tree
		tree := f([]int{1, 2, 3, 4, 5, 6, 7})
		assert.Equal(t, tree.ToString(), "(((1) 2 (3)) 4 ((5) 6 (7)))", name)
		assert.Equal(t, tree.Depth(), 3, name)

		// Complete tree
		tree = f([]int{1, 2, 3, 4, 5, 6})
		assert.Equal(t, tree.ToString(), "(((1) 2 (3)) 4 ((5) 6))", name)
		assert.Equal(t, tree.Depth(), 3, name)

		// Another complete tree
		tree = f([]int{1, 2, 3, 4, 5, 6, 7, 8, 9})
		assert.Equal(t, tree.ToString(), "((((1) 2) 3 (4)) 5 (((6) 7) 8 (9)))", name)
		assert.Equal(t, tree.Depth(), 4, name)
	}
}
