package trees_and_graphs

import (
	// . "github.com/holyketzer/ctci_v6/lib"
	// . "github.com/holyketzer/ctci_v6/test_helper"
	"gotest.tools/assert"
	"math"
	"testing"
)

func buildTree(t *testing.T) *RandomTree {
	tree := CreateRandomTree(nil)
	//        4
	//      /  \
	//     2    6
	//    / \    \
	//  1(2) 3    8
	for _, value := range []int{4, 2, 1, 3, 6, 1, 8} {
		tree.Insert(value)
	}
	assert.Equal(t, tree.ToString(), "(((1[2]) 2[1] (3[1])) 4[1] (6[1] (8[1])))")

	return tree
}

func getNodes(tree *RandomTree) (*RandomTreeNode, *RandomTreeNode, *RandomTreeNode, *RandomTreeNode, *RandomTreeNode) {
	return tree.Find(1), tree.Find(3), tree.Find(4), tree.Find(5), tree.Find(6)
}

func TestInsertFindDelete(t *testing.T) {
	// should find
	tree := buildTree(t)
	one, three, four, five, six := getNodes(tree)

	assert.Equal(t, one != nil, true)
	assert.Equal(t, one.Value, 1)
	assert.Equal(t, one.Count, 2)
	assert.Equal(t, five == nil, true)

	// should delete leaf
	tree = buildTree(t)
	one, three, four, five, six = getNodes(tree)

	assert.Equal(t, tree.Count(), 7)
	tree.Delete(three)
	assert.Equal(t, tree.Count(), 6)
	assert.Equal(t, tree.Find(3) == nil, true)

	// should decrease count if > 1
	tree = buildTree(t)
	one, three, four, five, six = getNodes(tree)

	assert.Equal(t, tree.Count(), 7)
	tree.Delete(one)
	assert.Equal(t, tree.Count(), 6)
	assert.Equal(t, tree.Find(1) != nil, true)
	assert.Equal(t, tree.Find(1).Count, 1)

	// should pull branch
	tree = buildTree(t)
	one, three, four, five, six = getNodes(tree)

	assert.Equal(t, tree.Count(), 7)
	tree.Delete(six)
	assert.Equal(t, tree.Count(), 6)
	assert.Equal(t, tree.Find(6) == nil, true)

	// should pull branch (root case)
	tree = buildTree(t)
	one, three, four, five, six = getNodes(tree)

	assert.Equal(t, tree.Count(), 7)
	tree.Delete(four)
	assert.Equal(t, tree.Count(), 6)
	assert.Equal(t, tree.Find(4) == nil, true)

	// should rotate branch
	tree = buildTree(t)
	one, three, four, five, six = getNodes(tree)

	tree.Insert(5)
	assert.Equal(t, tree.Count(), 8)
	tree.Delete(four)
	assert.Equal(t, tree.Count(), 7)
	assert.Equal(t, tree.Find(4) == nil, true)
}

func TestGetNodeByIndex(t *testing.T) {
	tree := buildTree(t)

	assert.Equal(t, tree.GetNodeByIndex(-1) == nil, true)
	assert.Equal(t, tree.GetNodeByIndex(0).Value, 1)
	assert.Equal(t, tree.GetNodeByIndex(1).Value, 1)
	assert.Equal(t, tree.GetNodeByIndex(2).Value, 2)
	assert.Equal(t, tree.GetNodeByIndex(3).Value, 3)
	assert.Equal(t, tree.GetNodeByIndex(4).Value, 4)
	assert.Equal(t, tree.GetNodeByIndex(5).Value, 6)
	assert.Equal(t, tree.GetNodeByIndex(6).Value, 8)
	assert.Equal(t, tree.GetNodeByIndex(7) == nil, true)
}

func TestGetRandomNode(t *testing.T) {
	tree := buildTree(t)
	valuesCount := make(map[int]int)

	// This is a stupid but funny: probability and Law of large numbers based test
	for i := 0; i < 1000; i++ {
		node := tree.GetRandomNode()
		assert.Equal(t, node != nil, true)
		valuesCount[node.Value] += 1
	}

	for k, v := range valuesCount {
		if k != 1 {
			// 1 - is presented in tree twice, all another values only once,
			// so it should be generated with x2 probability comparing to other values
			assert.Equal(t, v < valuesCount[1], true)
			assert.Equal(t, math.Round(float64(valuesCount[1])/float64(v)) >= 2, true)
		}
	}
}
