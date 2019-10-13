package trees_and_graphs

import (
	. "github.com/holyketzer/ctci_v6/lib"
	. "github.com/holyketzer/ctci_v6/test_helper"
	"gotest.tools/assert"
	"testing"
)

func TestIsSubtree(t *testing.T) {
	for _, f := range []func(*BinaryTree, *BinaryTree) bool{IsSubtreeA} {
		name := GetFunctionName(f)

		tree2 := SeqBuildBst([]int{5, 3, 7})

		// subtree
		actual := f(SeqBuildBst([]int{1, 0, 5, 3, 7}), tree2)
		assert.Equal(t, actual, true, name)

		// not a subtree but with similat sequence
		actual = f(SeqBuildBst([]int{2, 5, 3, 7, 8}), tree2)
		assert.Equal(t, actual, false, name)

		// same tree
		actual = f(SeqBuildBst([]int{5, 3, 7}), tree2)
		assert.Equal(t, actual, false, name)
	}
}
