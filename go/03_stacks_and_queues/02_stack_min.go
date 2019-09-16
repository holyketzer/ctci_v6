package stacks_and_queues

import (
	"bytes"
	"errors"
	"fmt"
)

// n - stack size
// O(1) for push, pop and min methods
type stackWithMin struct {
	tail *sNode
}

type sNode struct {
	value int
	min   int
	prev  *sNode
}

func NewSNode(value int, prev_min int, prev *sNode) *sNode {
	node := &sNode{value: value, prev: prev}

	if value < prev_min {
		node.min = value
	} else {
		node.min = prev_min
	}

	return node
}

func (s *stackWithMin) Push(value int) *stackWithMin {
	if s.tail != nil {
		s.tail = NewSNode(value, s.tail.min, s.tail)
	} else {
		s.tail = NewSNode(value, value, nil)
	}

	return s
}

func (s *stackWithMin) Pop() (int, error) {
	if s.tail != nil {
		value := s.tail.value
		s.tail = s.tail.prev
		return value, nil
	} else {
		return -1, errors.New("Stack is empty")
	}
}

func (s *stackWithMin) Min() (int, error) {
	if s.tail != nil {
		return s.tail.min, nil
	} else {
		return -1, errors.New("Stack is empty")
	}
}

func (s *stackWithMin) ToString() string {
	arr := []string{}
	curr := s.tail

	for curr != nil {
		arr = append(arr, fmt.Sprintf("v=%d m=%d", curr.value, curr.min))
		curr = curr.prev
	}

	res := bytes.Buffer{}
	res.WriteString("||")

	for i, s := range ReverseStrings(arr) {
		res.WriteString(s)

		if i < len(arr)-1 {
			res.WriteString(", ")
		}
	}

	res.WriteString("]")
	return res.String()
}
