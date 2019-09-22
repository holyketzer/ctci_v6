package trees_and_graphs

import (
	. "github.com/holyketzer/ctci_v6/lib"
)

// n - count of nodes
// Time - O(n), Mem = O(1)
func ValidBstA(tree *BinaryTree) bool {
	return ValidBstNode(tree.Root)
}

func ValidBstNode(node *BTNode) bool {
	left := node.Left

	if left != nil {
		if left.Value >= node.Value || ValidBstNode(left) == false {
			return false
		}
	}

	right := node.Right
	if right != nil {
		if right.Value <= node.Value || ValidBstNode(right) == false {
			return false
		}
	}

	return true
}
