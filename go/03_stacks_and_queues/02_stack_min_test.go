package stacks_and_queues

import (
	"gotest.tools/assert"
	"testing"
)

func TestStackWithMin(t *testing.T) {
	stack := stackWithMin{}

	stack.Push(1)
	m, _ := stack.Min()
	assert.Equal(t, m, 1)

	stack.Push(2)
	m, _ = stack.Min()
	assert.Equal(t, m, 1)

	stack.Push(0)
	m, _ = stack.Min()
	assert.Equal(t, m, 0)

	stack.Push(1)
	m, _ = stack.Min()
	assert.Equal(t, m, 0)

	v, _ := stack.Pop()
	m, _ = stack.Min()
	assert.Equal(t, v, 1)
	assert.Equal(t, m, 0)

	v, _ = stack.Pop()
	m, _ = stack.Min()
	assert.Equal(t, v, 0)
	assert.Equal(t, m, 1)

	v, _ = stack.Pop()
	m, _ = stack.Min()
	assert.Equal(t, v, 2)
	assert.Equal(t, m, 1)

	v, _ = stack.Pop()
	_, err := stack.Min()
	assert.Equal(t, v, 1)
	assert.Equal(t, err.Error(), "Stack is empty")

	_, err = stack.Pop()
	assert.Equal(t, err.Error(), "Stack is empty")
}
