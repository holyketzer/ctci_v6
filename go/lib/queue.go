package lib

import (
	"errors"
)

type QueueNode struct {
	value int
	next  *QueueNode
}

type Queue struct {
	head *QueueNode
	tail *QueueNode
}

func NewQueue() *Queue {
	return &Queue{}
}

func (q *Queue) Push(value int) *Queue {
	node := &QueueNode{value: value}

	if q.head == nil {
		q.head = node
		q.tail = node
	} else {
		q.tail.next = node
		q.tail = node
	}

	return q
}

func (q *Queue) Pop() (int, error) {
	if q.Any() {
		node := q.head
		q.head = node.next

		if q.head == nil {
			q.tail = nil
		}
		return node.value, nil
	} else {
		return -1, errors.New("queue is empty")
	}
}

func (q *Queue) Any() bool {
	return q.head != nil
}

func (q *Queue) Empty() bool {
	return q.head == nil
}
