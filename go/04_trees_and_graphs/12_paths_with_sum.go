package trees_and_graphs

import (
	. "github.com/holyketzer/ctci_v6/lib"
)

// n - count of nodes, k - depth of tree
// Time=O(n^2) Mem=O(k)
func PathsWithSumA(tree *BinaryTree, sum int) int {
	return CountOfPathsBfs(tree.Root, sum)
}

func CountOfPathsBfs(node *BTNode, sum int) int {
	if node == nil {
		return 0
	}

	res := 0
	q := []*BTNode{node}
	var curr *BTNode

	for len(q) > 0 {
		curr, q = q[0], q[1:]

		res += CountOfPathsFrom(curr, sum, 0)

		if curr.Left != nil {
			q = append(q, curr.Left)
		}

		if curr.Right != nil {
			q = append(q, curr.Right)
		}
	}

	return res
}

func CountOfPathsFrom(node *BTNode, sum int, curr int) int {
	if node == nil {
		return 0
	}

	res := 0
	curr += node.Value

	if curr == sum {
		res += 1
	} else if curr > sum {
		return 0
	}

	return res + CountOfPathsFrom(node.Left, sum, curr) + CountOfPathsFrom(node.Right, sum, curr)
}

// n - count of nodes, k - depth of tree
// Time=O(n) Mem=O(k)
func PathsWithSumB(tree *BinaryTree, sum int) int {
	return CountOfPathsForB(tree.Root, sum, 0, make(map[int]int))
}

func CountOfPathsForB(node *BTNode, target int, curr int, currCounter map[int]int) int {
	if node == nil {
		return 0
	}

	curr += node.Value
	res := 0

	if curr == target {
		res += 1
	}

	currCounter[curr] += 1
	diff := curr - target

	if val, ok := currCounter[diff]; ok {
		res += val
	}

	res += CountOfPathsForB(node.Left, target, curr, currCounter)
	res += CountOfPathsForB(node.Right, target, curr, currCounter)

	currCounter[curr] -= 1
	return res
}
