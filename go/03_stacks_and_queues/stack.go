package stacks_and_queues

import (
	"bytes"
	"errors"
	"strconv"
)

type stackNode struct {
	value int
	prev  *stackNode
}

type stack struct {
	tail *stackNode
}

func Reverse(arr []int) []int {
	for i := len(arr)/2 - 1; i >= 0; i-- {
		opp := len(arr) - 1 - i
		arr[i], arr[opp] = arr[opp], arr[i]
	}

	return arr
}

func ReverseStrings(arr []string) []string {
	for i := len(arr)/2 - 1; i >= 0; i-- {
		opp := len(arr) - 1 - i
		arr[i], arr[opp] = arr[opp], arr[i]
	}

	return arr
}

func SliceToStack(arr []int) *stack {
	s := &stack{}

	for _, value := range Reverse(arr) {
		s.Push(value)
	}

	return s
}

func (s *stack) Push(value int) *stack {
	s.tail = &stackNode{value: value, prev: s.tail}
	return s
}

func (s *stack) Pop() (int, error) {
	if s.tail != nil {
		value := s.tail.value
		s.tail = s.tail.prev
		return value, nil
	} else {
		return -1, errors.New("stack is empty")
	}
}

func (s *stack) Empty() bool {
	return s.tail == nil
}

func (s *stack) Peek() (int, error) {
	if s.tail != nil {
		return s.tail.value, nil
	} else {
		return -1, errors.New("stack is empty")
	}
}

func (s *stack) ToSlice() []int {
	res := []int{}
	curr := s.tail

	for curr != nil {
		res = append(res, curr.value)
		curr = curr.prev
	}

	return Reverse(res)
}

func (s *stack) ToString() string {
	arr := s.ToSlice()
	res := bytes.Buffer{}

	res.WriteString("||")

	for i, v := range arr {
		res.WriteString(strconv.Itoa(v))

		if i < len(arr)-1 {
			res.WriteString(", ")
		}
	}

	res.WriteString("]")
	return res.String()
}
