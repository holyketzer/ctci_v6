package stacks_and_queues

import (
	"gotest.tools/assert"
	"testing"
)

func TestSetOfStacksPushPop(t *testing.T) {
	stack := NewSetOfStacks(3)

	for i := 0; i < 10; i++ {
		stack.Push(i)
	}

	for i := 9; i >= 0; i-- {
		v, _ := stack.Pop()
		assert.Equal(t, v, i)
	}

	_, err := stack.Pop()
	assert.Equal(t, err.Error(), "All stacks are empty")
}

func TestSetOfStacksDoublePushPop(t *testing.T) {
	stack := NewSetOfStacks(3)

	for i := 0; i < 3; i++ {
		stack.Push(i)
	}

	v, _ := stack.Pop()
	assert.Equal(t, v, 2)

	stack.Push(3)
	stack.Push(4)

	v, _ = stack.Pop()
	assert.Equal(t, v, 4)

	stack.Push(5)

	v, _ = stack.Pop()
	assert.Equal(t, v, 5)
	v, _ = stack.Pop()
	assert.Equal(t, v, 3)
	v, _ = stack.Pop()
	assert.Equal(t, v, 1)
	v, _ = stack.Pop()
	assert.Equal(t, v, 0)
}

func TestSetOfStacksPushPopAt(t *testing.T) {
	stack := NewSetOfStacks(3)

	for i := 0; i < 10; i++ {
		stack.Push(i)
	}

	v, _ := stack.PopAt(2)
	assert.Equal(t, v, 8)
	v, _ = stack.PopAt(2)
	assert.Equal(t, v, 7)
	v, _ = stack.PopAt(2)
	assert.Equal(t, v, 6)
	_, err := stack.PopAt(2)
	assert.Equal(t, err.Error(), "All stacks are empty")

	v, _ = stack.PopAt(0)
	assert.Equal(t, v, 2)
	v, _ = stack.PopAt(0)
	assert.Equal(t, v, 1)

	v, _ = stack.Pop()
	assert.Equal(t, v, 9)
	v, _ = stack.Pop()
	assert.Equal(t, v, 5)
	v, _ = stack.Pop()
	assert.Equal(t, v, 4)
	v, _ = stack.Pop()
	assert.Equal(t, v, 3)
	v, _ = stack.Pop()
	assert.Equal(t, v, 0)

	// Here stack clean, push again
	for i := 0; i < 10; i++ {
		stack.Push(i)
	}

	v, _ = stack.PopAt(3)
	assert.Equal(t, v, 9)
	_, err = stack.PopAt(3)
	assert.Equal(t, err.Error(), "All stacks are empty")

	v, _ = stack.PopAt(1)
	assert.Equal(t, v, 5)
	v, _ = stack.PopAt(1)
	assert.Equal(t, v, 4)

	stack.Push(20)
	stack.Push(30)

	v, _ = stack.Pop()
	assert.Equal(t, v, 30)
	v, _ = stack.Pop()
	assert.Equal(t, v, 20)
}
