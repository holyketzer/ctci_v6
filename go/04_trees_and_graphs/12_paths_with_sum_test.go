package trees_and_graphs

import (
	. "github.com/holyketzer/ctci_v6/lib"
	. "github.com/holyketzer/ctci_v6/test_helper"
	"gotest.tools/assert"
	"testing"
)

func TestPathsWithSum(t *testing.T) {
	for _, f := range []func(*BinaryTree, int) int{PathsWithSumA, PathsWithSumB} {
		name := GetFunctionName(f)

		root := &BTNode{Value: 1}
		tree := &BinaryTree{Root: root}

		// Level 1
		l := root.AppendLeft(2)
		r := root.AppendRight(2)

		// Level 2
		l_l := l.AppendLeft(3)
		l_r := l.AppendRight(3)
		r_l := r.AppendLeft(3)
		r_r := r.AppendRight(3)

		// Level 3
		l_l.AppendLeft(1)
		l_l.AppendRight(0)
		l_r.AppendRight(1)
		r_l.AppendLeft(1)
		r_r.AppendLeft(3)
		r_r.AppendRight(4)

		//            1
		//         /    \
		//        /      \
		//       /        \
		//      2          2
		//     / \        / \
		//    3   3      3   3
		//   / \   \    /   / \
		//  1   0   1  1   3   4

		sum := 6
		assert.Equal(t, f(tree, sum), 9, name)
	}
}
