package trees_and_graphs

import (
	. "github.com/holyketzer/ctci_v6/lib"
)

// n - count of nodes, k - depth
// Time - O(k), Mem = O(1)
func NextNodeA(node *BTNode) *BTNode {
	return FindNextNode(node, node.Value)
}

func FindNextNode(curr *BTNode, value int) *BTNode {
	if curr.Value == value+1 {
		return curr
	}

	left := curr.Left
	if left != nil {
		if left.Value > value {
			return FindNextNode(left, value)
		}
	}

	right := curr.Right
	if right != nil {
		if right.Value > value {
			return FindNextNode(right, value)
		}
	}

	if curr.Value > value {
		return curr
	}

	parent := curr.Parent
	if parent != nil {
		if LeftSubtree(curr) {
			return parent
		}

		return FindNextNode(parent, value)
	}

	return nil
}

func LeftSubtree(node *BTNode) bool {
	return node.Parent != nil && node.Parent.Left == node
}
