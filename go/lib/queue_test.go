package lib

import (
	"gotest.tools/assert"
	"testing"
)

func TestQueue(t *testing.T) {
	queue := NewQueue()
	assert.Equal(t, queue.Any(), false)
	assert.Equal(t, queue.Empty(), true)

	queue.Push(1)
	queue.Push(2)
	queue.Push(3)
	assert.Equal(t, queue.Any(), true)
	assert.Equal(t, queue.Empty(), false)

	v, _ := queue.Pop()
	assert.Equal(t, v, 1)

	v, _ = queue.Pop()
	assert.Equal(t, v, 2)

	v, _ = queue.Pop()
	assert.Equal(t, v, 3)

	_, err := queue.Pop()
	assert.Equal(t, err.Error(), "queue is empty")

	queue.Push(4)
	v, _ = queue.Pop()
	assert.Equal(t, v, 4)

	_, err = queue.Pop()
	assert.Equal(t, err.Error(), "queue is empty")
}
