package linked_lists

import (
	"github.com/golang-collections/collections/set"
)

// n - list size
// time = O(n), mem = O(n)
func RemoveDupsB(head *llnode) *llnode {
	s := set.New()
	curr := head

	for curr != nil {
		s.Insert(curr.value)
		curr = curr.next
	}

	curr = head
	var prev *llnode

	for curr != nil {
		if s.Has(curr.value) {
			s.Remove(curr.value)
			prev = curr
		} else {
			prev.next = curr.next
		}

		curr = curr.next
	}

	return head
}

// time = O(n*log(n)), mem = O(n)
func RemoveDupsC(head *llnode) *llnode {
	head = SortLL(head)
	curr := head

	for curr.next != nil {
		if curr.value == curr.next.value {
			curr.next = curr.next.next
		} else {
			curr = curr.next
		}
	}

	return head
}

func SortLL(head *llnode) *llnode {
	if head.LLSize() < 2 {
		return head
	} else {
		a, b := HalveList(head)
		return MergeSortedLL(SortLL(a), SortLL(b))
	}
}

func HalveList(head *llnode) (*llnode, *llnode) {
	half := head.LLSize() / 2
	a := head
	curr := a
	aSize := 1

	for aSize < half {
		curr = curr.next
		aSize += 1
	}

	b := curr.next
	curr.next = nil
	return a, b
}

func MergeSortedLL(a *llnode, b *llnode) *llnode {
	var head *llnode

	if a.value < b.value {
		head = a
		a = a.next
	} else {
		head = b
		b = b.next
	}

	curr := head

	for a != nil || b != nil {
		if a != nil && b != nil {
			if a.value < b.value {
				curr.next = a
				a = a.next
			} else {
				curr.next = b
				b = b.next
			}
		} else if a != nil {
			curr.next = a
			a = a.next
		} else {
			curr.next = b
			b = b.next
		}

		curr = curr.next
	}

	return head
}
