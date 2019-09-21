package stacks_and_queues

import (
	"bytes"
	"strconv"
)

type doubleStackQueue struct {
	in  *stack
	out *stack
}

func NewDoubleStackQueue() *doubleStackQueue {
	return &doubleStackQueue{
		in:  &stack{},
		out: &stack{},
	}
}

func (q *doubleStackQueue) Push(value int) *doubleStackQueue {
	x, err := q.out.Pop()

	for err == nil {
		q.in.Push(x)
		x, err = q.out.Pop()
	}

	q.in.Push(value)
	return q
}

func (q *doubleStackQueue) Pop() (int, error) {
	x, err := q.in.Pop()

	for err == nil {
		q.out.Push(x)
		x, err = q.in.Pop()
	}

	return q.out.Pop()
}

func (q *doubleStackQueue) ToString() string {
	arrOut := make([]int, 0)
	curr := q.out.tail

	for curr != nil {
		arrOut = append(arrOut, curr.value)
		curr = curr.prev
	}

	arrIn := make([]int, 0)
	curr = q.in.tail

	for curr != nil {
		arrIn = append(arrIn, curr.value)
		curr = curr.prev
	}

	arr := append(arrOut, Reverse(arrIn)...)
	res := bytes.Buffer{}
	res.WriteString("[<")

	for v := range arr {
		res.WriteString(strconv.Itoa(v))
	}

	res.WriteString("<]")

	return res.String()
}
