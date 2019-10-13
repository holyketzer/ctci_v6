package trees_and_graphs

import (
	. "github.com/holyketzer/ctci_v6/lib"
)

// t1 - count of nodes in T1, t2 - count of nodes in T2, T1 much bigger that t2
// Time = O(t1*t2), Mem = O(1)
func IsSubtreeA(t1 *BinaryTree, t2 *BinaryTree) bool {
	return IsSimilarTrees(t1.Root.Left, t2.Root, t2.Root) || IsSimilarTrees(t1.Root.Right, t2.Root, t2.Root)
}

func IsSimilarTrees(node1 *BTNode, node2 *BTNode, tree2Root *BTNode) bool {
	if node1 == nil && node2 == nil {
		return true
	} else if node1 != nil && node2 != nil && node1.Value == node2.Value {
		if IsSimilarTrees(node1.Left, node2.Left, tree2Root) && IsSimilarTrees(node1.Right, node2.Right, tree2Root) {
			return true
		}
	} else if node1 != nil {
		if IsSimilarTrees(node1.Left, tree2Root, tree2Root) || IsSimilarTrees(node1.Right, tree2Root, tree2Root) {
			return true
		}
	}

	return false
}
