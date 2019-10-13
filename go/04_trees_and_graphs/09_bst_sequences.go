package trees_and_graphs

import (
	. "github.com/holyketzer/ctci_v6/lib"
)

func SeqBuildBst(arr []int) *BinaryTree {
	var root *BTNode

	for _, v := range arr {
		if root != nil {
			AppendValueToBst(root, v)
		} else {
			root = &BTNode{Value: v}
		}
	}

	return &BinaryTree{Root: root}
}

func AppendValueToBst(curr *BTNode, v int) {
	if v < curr.Value {
		if curr.Left != nil {
			AppendValueToBst(curr.Left, v)
		} else {
			curr.Left = &BTNode{Value: v}
		}
	} else {
		if curr.Right != nil {
			AppendValueToBst(curr.Right, v)
		} else {
			curr.Right = &BTNode{Value: v}
		}
	}
}

// All tree items are uniq
// n - count of nodes
// Time = (4^n) Mem = O(4^n)
// Дальше код на блядском Go
func BstSequencesA(tree *BinaryTree) [][]int {
	res := [][]int{}
	seq := []int{tree.Root.Value}

	nextNodes := AppendNextNodes([]*BTNode{}, tree.Root, -1)
	return GeneratePermutations(seq, nextNodes, res)
}

func GeneratePermutations(seq []int, nextNodes []*BTNode, res [][]int) [][]int {
	if len(nextNodes) == 0 {
		res = append(res, seq)
	} else {
		for i, node := range nextNodes {
			subSeq := append(seq, node.Value)
			subNext := AppendNextNodes(nextNodes, node, i)
			res = GeneratePermutations(subSeq, subNext, res)
		}
	}

	return res
}

func AppendNextNodes(nextNodes []*BTNode, currNode *BTNode, removeIndex int) []*BTNode {
	res := []*BTNode{}

	for i, node := range nextNodes {
		if i != removeIndex {
			res = append(res, node)
		}
	}

	if currNode.Left != nil {
		res = append(res, currNode.Left)
	}

	if currNode.Right != nil {
		res = append(res, currNode.Right)
	}

	return res
}
