package stacks_and_queues

import (
	"errors"
	"fmt"
)

// n - one stack size
type nStacksArray struct {
	stack_size   int
	stacks_count int
	arr          []int
	// Indexes of head and tail of stack
	heads []int
	tails []int
}

func NewNStacksArray(stack_size int, stacks_count int) *nStacksArray {
	sa := &nStacksArray{
		stack_size:   stack_size,
		stacks_count: stacks_count,
		arr:          make([]int, stacks_count*stack_size),
		heads:        make([]int, stacks_count),
		tails:        make([]int, stacks_count),
	}

	for i := 0; i < stacks_count; i++ {
		sa.heads[i] = i * stack_size
		sa.tails[i] = sa.heads[i]
	}

	return sa
}

func (sa *nStacksArray) Size(stack int) int {
	si := stack - 1
	return sa.tails[si] - sa.heads[si]
}

func (sa *nStacksArray) Push(stack int, value int) (bool, error) {
	if sa.Size(stack) < sa.stack_size {
		si := stack - 1
		sa.tails[si] += 1
		index := sa.tails[si]
		sa.arr[index] = value
		return true, nil
	} else {
		return false, errors.New(fmt.Sprintf("Stack #%d is overflown", stack))
	}
}

func (sa *nStacksArray) Pop(stack int) (int, error) {
	if sa.Size(stack) > 0 {
		si := stack - 1
		i := sa.tails[si]
		sa.tails[si] -= 1
		return sa.arr[i], nil
	} else {
		return -1, errors.New(fmt.Sprintf("Stack #%d is empty", stack))
	}
}

func (sa *nStacksArray) Peek(stack int) (int, error) {
	if sa.Size(stack) > 0 {
		return sa.arr[stack-1], nil
	} else {
		return -1, errors.New(fmt.Sprintf("Stack #%d is empty", stack))
	}
}
