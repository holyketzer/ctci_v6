package linked_lists

import (
	"errors"
)

// n - list size
// time = O(n), mem = O(1)
func KthA(head *llnode, k int) (int, error) {
	n := head.LLSize()

	var res *int
	curr := head
	i := 0

	for n-i >= k {
		res = &curr.value
		curr = curr.next
		i += 1
	}

	if res != nil {
		return *res, nil
	} else {
		return -1, errors.New("list is blank")
	}
}

// time = O(n), mem = O(n), recursive
func KthB(head *llnode, k int) (int, error) {
	n := head.LLSize()
	res := NthRecursuve(head, n-k)

	if res != nil {
		return *res, nil
	} else {
		return -1, errors.New("list is blank")
	}
}

func NthRecursuve(head *llnode, i int) *int {
	if i == 0 || head == nil {
		if head == nil {
			return nil
		} else {
			return &head.value
		}
	} else {
		return NthRecursuve(head.next, i-1)
	}
}

// time = O(n), mem = O(1), fast and slow iterators
func KthC(head *llnode, k int) (int, error) {
	slow := head
	fast := head
	slowCounter := 0
	size := 0

	for fast != nil {
		fast = fast.next
		size += 1

		if fast != nil {
			slow = slow.next
			fast = fast.next
			slowCounter += 1
			size += 1
		}
	}

	index := size - k

	if index < 0 || index > size {
		return -1, errors.New("list is blank")
	} else if index > slowCounter {
		for index != slowCounter {
			slow = slow.next
			slowCounter += 1
		}
		return slow.value, nil
	} else {
		curr := head
		for i := 0; index != i; i++ {
			curr = curr.next
		}
		return curr.value, nil
	}
}
