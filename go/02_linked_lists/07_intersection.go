package linked_lists

// time = O(n), mem = O(1)
func IntersectionA(a *llnode, b *llnode) bool {
	aTail := a
	bTail := b

	for aTail.next != nil {
		aTail = aTail.next
	}

	for bTail.next != nil {
		bTail = bTail.next
	}

	return aTail == bTail
}
