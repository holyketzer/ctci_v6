package trees_and_graphs

import (
	"bytes"
	"math/rand"
	"strconv"
)

type RandomTreeNode struct {
	Value  int
	Parent *RandomTreeNode
	Count  int
	Left   *RandomTreeNode
	Right  *RandomTreeNode
}

func CreateRandomTreeNode(value int, parent *RandomTreeNode) *RandomTreeNode {
	return &RandomTreeNode{
		Value:  value,
		Parent: parent,
		Count:  1,
	}
}

func (n *RandomTreeNode) ItselfCount() int {
	res := n.Count

	if n.Left != nil {
		res -= n.Left.Count
	}

	if n.Right != nil {
		res -= n.Right.Count
	}

	return res
}

func (n *RandomTreeNode) ToString() string {
	res := bytes.Buffer{}

	if n.Left != nil {
		res.WriteString("(")
		res.WriteString(n.Left.ToString())
		res.WriteString(") ")
	}

	res.WriteString(strconv.Itoa(n.Value))
	res.WriteString("[")
	res.WriteString(strconv.Itoa(n.ItselfCount()))
	res.WriteString("]")

	if n.Right != nil {
		res.WriteString(" (")
		res.WriteString(n.Right.ToString())
		res.WriteString(")")
	}

	return res.String()
}

type RandomTree struct {
	Root *RandomTreeNode
}

func CreateRandomTree(root *RandomTreeNode) *RandomTree {
	return &RandomTree{Root: root}
}

func (t *RandomTree) Count() int {
	if t.Root != nil {
		return t.Root.Count
	} else {
		return 0
	}
}

// Time = O(k), Mem = O(k)
func (t *RandomTree) Insert(value int) {
	if t.Root == nil {
		t.Root = CreateRandomTreeNode(value, nil)
	} else {
		t.AppendValue(t.Root, value)
	}
}

func (t *RandomTree) AppendValue(node *RandomTreeNode, value int) {
	if node.Value == value {
		node.Count += 1
	} else if node.Value > value {
		node.Count += 1

		if node.Left != nil {
			t.AppendValue(node.Left, value)
		} else {
			node.Left = CreateRandomTreeNode(value, node)
		}
	} else {
		node.Count += 1

		if node.Right != nil {
			t.AppendValue(node.Right, value)
		} else {
			node.Right = CreateRandomTreeNode(value, node)
		}
	}
}

// Time = O(k), Mem = O(1)
func (t *RandomTree) Find(value int) *RandomTreeNode {
	curr := t.Root

	for curr != nil {
		if curr.Value == value {
			return curr
		} else {
			if curr.Value > value {
				curr = curr.Left
			} else {
				curr = curr.Right
			}
		}
	}

	return nil
}

func (t *RandomTree) ReplaceNode(node *RandomTreeNode, newNode *RandomTreeNode) {
	parent := node.Parent

	if parent != nil {
		if parent.Left == node {
			parent.Left = newNode
		} else {
			parent.Right = newNode
		}

		if newNode != nil {
			newNode.Parent = parent
		}
	}

	if node == t.Root {
		t.Root = newNode
	}
}

// Time = O(k), Mem = O(k)
func (t *RandomTree) Delete(node *RandomTreeNode) {
	node.Count -= 1

	l := node.Left
	r := node.Right

	if node.ItselfCount() > 0 {
		t.DecCountInParents(node.Parent)
	} else if node.Left == nil && node.Right == nil {
		t.ReplaceNode(node, nil)
		t.DecCountInParents(node.Parent)
	} else if l != nil && l.Right == nil {
		l.Right = node.Right

		if l.Right != nil {
			l.Count += node.Right.Count
		}

		t.ReplaceNode(node, l)
		t.DecCountInParents(node.Parent)
	} else if r != nil && r.Left == nil {
		r.Left = node.Left

		if r.Left != nil {
			r.Count += node.Left.Count
		}

		t.ReplaceNode(node, r)
		t.DecCountInParents(node.Parent)
	} else if l != nil {
		lr := l.Right
		node.Value = lr.Value
		node.Count += 1
		t.Delete(lr)
	} else if r != nil {
		rl := r.Left
		node.Value = rl.Value
		node.Count += 1
		t.Delete(rl)
	} else {
		panic("unexpected case")
	}
}

func (t *RandomTree) DecCountInParents(parent *RandomTreeNode) {
	for parent != nil {
		parent.Count -= 1
		parent = parent.Parent
	}
}

func (t *RandomTree) ToString() string {
	return "(" + t.Root.ToString() + ")"
}

// Time = O(k), Mem = O(k)
func (t *RandomTree) GetRandomNode() *RandomTreeNode {
	if t.Root != nil {
		return t.GetNodeByIndex(rand.Intn(t.Root.Count))
	} else {
		return nil
	}
}

func (t *RandomTree) GetNodeByIndex(i int) *RandomTreeNode {
	return t.GetNodeByIndexFrom(t.Root, i)
}

// Order: left -> curr -> right, indexing: 0..n-1
func (t *RandomTree) GetNodeByIndexFrom(node *RandomTreeNode, i int) *RandomTreeNode {
	if node != nil {
		lCount := 0

		if node.Left != nil {
			lCount = node.Left.Count
		}

		if i-lCount < 0 {
			return t.GetNodeByIndexFrom(node.Left, i)
		} else if i-lCount < node.ItselfCount() {
			return node
		} else {
			return t.GetNodeByIndexFrom(node.Right, i-lCount-node.ItselfCount())
		}
	}

	return nil
}
