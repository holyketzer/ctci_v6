package stacks_and_queues

import (
	"gotest.tools/assert"
	"testing"
)

func TestDoubleStackQueue(t *testing.T) {
	queue := NewDoubleStackQueue()

	for i := 1; i < 4; i++ {
		queue.Push(i)
	}

	for i := 1; i < 4; i++ {
		v, _ := queue.Pop()
		assert.Equal(t, v, i)
	}

	_, err := queue.Pop()
	assert.Equal(t, err.Error(), "stack is empty")

	for i := 4; i < 7; i++ {
		queue.Push(i)
	}

	v, _ := queue.Pop()
	assert.Equal(t, v, 4)

	queue.Push(7)

	for i := 5; i < 8; i++ {
		v, _ := queue.Pop()
		assert.Equal(t, v, i)
	}

	_, err = queue.Pop()
	assert.Equal(t, err.Error(), "stack is empty")
}
