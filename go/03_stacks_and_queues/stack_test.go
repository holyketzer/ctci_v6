package stacks_and_queues

import (
	"gotest.tools/assert"
	"testing"
)

func TestSliceToStack(t *testing.T) {
	stack := SliceToStack([]int{1, 2, 3, 4, 5})
	actual := stack.ToString()

	assert.Equal(t, actual, "||5, 4, 3, 2, 1]")
}

func TestPopPeekEmpty(t *testing.T) {
	stack := SliceToStack([]int{1, 2})

	v, _ := stack.Pop()
	assert.Equal(t, v, 1)
	assert.Equal(t, stack.Empty(), false)

	v, _ = stack.Peek()
	assert.Equal(t, v, 2)
	assert.Equal(t, stack.Empty(), false)

	v, _ = stack.Pop()
	assert.Equal(t, v, 2)
	assert.Equal(t, stack.Empty(), true)

	_, err := stack.Peek()
	assert.Equal(t, err.Error(), "stack is empty")
}
