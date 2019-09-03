package linked_lists

// time = O(n), mem = O(1)
func PartitionB(head *llnode, x int) *llnode {
	l := head
	r := head.next

	for l.value >= x {
		SwapValues(l, r)
		r = r.next
	}

	for r != nil {
		if r.value < x {
			l = l.next
			SwapValues(l, r)
		}

		r = r.next
	}

	return head
}

func SwapValues(a *llnode, b *llnode) {
	tmp := a.value
	a.value = b.value
	b.value = tmp
}
