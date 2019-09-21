package linked_lists

import (
	"github.com/golang-collections/collections/set"
	. "github.com/holyketzer/ctci_v6/lib"
)

// n - list size
// time = O(n), mem = O(n)
func RemoveDupsB(head *LLNode) *LLNode {
	s := set.New()
	curr := head

	for curr != nil {
		s.Insert(curr.Value)
		curr = curr.Next
	}

	curr = head
	var prev *LLNode

	for curr != nil {
		if s.Has(curr.Value) {
			s.Remove(curr.Value)
			prev = curr
		} else {
			prev.Next = curr.Next
		}

		curr = curr.Next
	}

	return head
}

// time = O(n*log(n)), mem = O(n)
func RemoveDupsC(head *LLNode) *LLNode {
	head = SortLL(head)
	curr := head

	for curr.Next != nil {
		if curr.Value == curr.Next.Value {
			curr.Next = curr.Next.Next
		} else {
			curr = curr.Next
		}
	}

	return head
}

func SortLL(head *LLNode) *LLNode {
	if head.LLSize() < 2 {
		return head
	} else {
		a, b := HalveList(head)
		return MergeSortedLL(SortLL(a), SortLL(b))
	}
}

func HalveList(head *LLNode) (*LLNode, *LLNode) {
	half := head.LLSize() / 2
	a := head
	curr := a
	aSize := 1

	for aSize < half {
		curr = curr.Next
		aSize += 1
	}

	b := curr.Next
	curr.Next = nil
	return a, b
}

func MergeSortedLL(a *LLNode, b *LLNode) *LLNode {
	var head *LLNode

	if a.Value < b.Value {
		head = a
		a = a.Next
	} else {
		head = b
		b = b.Next
	}

	curr := head

	for a != nil || b != nil {
		if a != nil && b != nil {
			if a.Value < b.Value {
				curr.Next = a
				a = a.Next
			} else {
				curr.Next = b
				b = b.Next
			}
		} else if a != nil {
			curr.Next = a
			a = a.Next
		} else {
			curr.Next = b
			b = b.Next
		}

		curr = curr.Next
	}

	return head
}
