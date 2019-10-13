package lib

import (
	"bytes"
	"strconv"
)

type BTNode struct {
	Value  int
	Left   *BTNode
	Right  *BTNode
	Parent *BTNode
}

func (n *BTNode) Depth() int {
	subtreeDepth := 0

	if n.Left != nil {
		subtreeDepth = n.Left.Depth()
	}

	if n.Right != nil {
		if n.Right.Depth() > subtreeDepth {
			subtreeDepth = n.Right.Depth()
		}
	}

	return 1 + subtreeDepth
}

func (n *BTNode) ToString() string {
	res := bytes.Buffer{}

	if n.Left != nil {
		res.WriteString("(")
		res.WriteString(n.Left.ToString())
		res.WriteString(") ")
	}

	res.WriteString(strconv.Itoa(n.Value))

	if n.Right != nil {
		res.WriteString(" (")
		res.WriteString(n.Right.ToString())
		res.WriteString(")")
	}

	return res.String()
}

func (n *BTNode) AppendLeft(value int) *BTNode {
	n.Left = &BTNode{Value: value, Parent: n}
	return n.Left
}

func (n *BTNode) AppendRight(value int) *BTNode {
	n.Right = &BTNode{Value: value, Parent: n}
	return n.Right
}

type BinaryTree struct {
	Root *BTNode
}

func (t *BinaryTree) ToString() string {
	res := bytes.Buffer{}

	res.WriteString("(")
	res.WriteString(t.Root.ToString())
	res.WriteString(")")

	return res.String()
}

func (t *BinaryTree) Depth() int {
	if t.Root != nil {
		return t.Root.Depth()
	} else {
		return 0
	}
}
