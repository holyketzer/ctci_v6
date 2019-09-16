package stacks_and_queues

import (
	"gotest.tools/assert"
	"testing"
)

func TestNStacksArray(t *testing.T) {
	stack := NewNStacksArray(5, 3)

	stack.Push(1, 11)

	stack.Push(2, 12)
	stack.Push(2, 13)

	stack.Push(3, 14)
	stack.Push(3, 15)
	stack.Push(3, 16)

	// Stack 1
	v, _ := stack.Pop(1)
	assert.Equal(t, v, 11)

	_, err := stack.Pop(1)
	assert.Equal(t, err.Error(), "Stack #1 is empty")

	// Stack 2
	v, _ = stack.Pop(2)
	assert.Equal(t, v, 13)

	v, _ = stack.Pop(2)
	assert.Equal(t, v, 12)

	_, err = stack.Pop(2)
	assert.Equal(t, err.Error(), "Stack #2 is empty")

	// Stack 3
	v, _ = stack.Pop(3)
	assert.Equal(t, v, 16)

	v, _ = stack.Pop(3)
	assert.Equal(t, v, 15)

	v, _ = stack.Pop(3)
	assert.Equal(t, v, 14)

	_, err = stack.Pop(3)
	assert.Equal(t, err.Error(), "Stack #3 is empty")
}

func TestNStacksArrayOverflow(t *testing.T) {
	stack := NewNStacksArray(5, 3)

	for i := 0; i < 5; i++ {
		stack.Push(1, i)
	}

	assert.Equal(t, stack.Size(1), 5)

	_, err := stack.Push(1, 6)
	assert.Equal(t, err.Error(), "Stack #1 is overflown")
}
