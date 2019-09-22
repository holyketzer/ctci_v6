package trees_and_graphs

import (
	. "github.com/holyketzer/ctci_v6/lib"
	. "github.com/holyketzer/ctci_v6/test_helper"
	"gotest.tools/assert"
	"testing"
)

func TestListsOfDepth(t *testing.T) {
	for _, f := range []func(tree *BinaryTree) map[int]([]*BTNode){ListsOfDepthA} {
		name := GetFunctionName(f)

		// Perfect tree
		tree := ArrayToBstA([]int{1, 2, 3, 4, 5, 6, 7})
		actual := f(tree)
		assert.Equal(t, actual[0][0].Value, 4, name)
		assert.Equal(t, actual[1][0].Value, 2, name)
		assert.Equal(t, actual[1][1].Value, 6, name)
		assert.Equal(t, actual[2][0].Value, 1, name)
		assert.Equal(t, actual[2][1].Value, 3, name)
		assert.Equal(t, actual[2][2].Value, 5, name)
		assert.Equal(t, actual[2][3].Value, 7, name)

		// Not perfect tree
		tree = ArrayToBstA([]int{1, 2, 3, 4, 5, 6, 7, 8})
		actual = f(tree)
		assert.Equal(t, actual[0][0].Value, 5, name)
		assert.Equal(t, actual[1][0].Value, 3, name)
		assert.Equal(t, actual[1][1].Value, 7, name)
		assert.Equal(t, actual[2][0].Value, 2, name)
		assert.Equal(t, actual[2][1].Value, 4, name)
		assert.Equal(t, actual[2][2].Value, 6, name)
		assert.Equal(t, actual[2][3].Value, 8, name)
		assert.Equal(t, actual[3][0].Value, 1, name)
	}
}
