package trees_and_graphs

import (
	. "github.com/holyketzer/ctci_v6/lib"
	. "github.com/holyketzer/ctci_v6/test_helper"
	"gotest.tools/assert"
	"testing"
)

func TestNextNode(t *testing.T) {
	for _, f := range []func(*BTNode) *BTNode{NextNodeA} {
		name := GetFunctionName(f)

		// BST tree without spaces
		tree := ArrayToBstA([]int{1, 2, 3, 4, 5, 6, 7})
		firstNode := tree.Root.Left.Left
		assert.Equal(t, firstNode.Value, 1, name)

		node := f(firstNode)
		assert.Equal(t, node.Value, 2, name)

		node = f(node)
		assert.Equal(t, node.Value, 3, name)

		node = f(node)
		assert.Equal(t, node.Value, 4, name)

		node = f(node)
		assert.Equal(t, node.Value, 5, name)

		node = f(node)
		assert.Equal(t, node.Value, 6, name)

		node = f(node)
		assert.Equal(t, node.Value, 7, name)

		assert.Equal(t, f(node) == nil, true, name)

		// BST tree with spaces
		//             9
		//       5           15
		//    3    7      12    20
		// 1           11
		tree = ArrayToBstA([]int{1, 3, 5, 7, 9, 11, 12, 15, 20})

		firstNode = tree.Root.Left.Left.Left
		assert.Equal(t, firstNode.Value, 1, name)

		node = f(firstNode)
		assert.Equal(t, node.Value, 3, name)

		node = f(node)
		assert.Equal(t, node.Value, 5, name)

		node = f(node)
		assert.Equal(t, node.Value, 7, name)

		node = f(node)
		assert.Equal(t, node.Value, 9, name)

		node = f(node)
		assert.Equal(t, node.Value, 11, name)

		node = f(node)
		assert.Equal(t, node.Value, 12, name)

		node = f(node)
		assert.Equal(t, node.Value, 15, name)

		node = f(node)
		assert.Equal(t, node.Value, 20, name)

		assert.Equal(t, f(node) == nil, true, name)
	}
}
