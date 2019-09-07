package linked_lists

// time = O(n), mem = O(n)
func SumListsReversed(a *llnode, b *llnode) *llnode {
	var res_head *llnode
	var res *llnode
	shift := 0

	for a != nil || b != nil {
		v := shift

		if a != nil {
			v += a.value
		}

		if b != nil {
			v += b.value
		}

		shift = v / 10
		node := llnode{value: v % 10}

		if res != nil {
			res.next = &node
		} else {
			res_head = &node
		}

		res = &node

		if a != nil {
			a = a.next
		}

		if b != nil {
			b = b.next
		}
	}

	return res_head
}

// time = O(n), mem = O(n)
func SumListsDirect(a *llnode, b *llnode) *llnode {
	sum := LLToI(a, 10) + LLToI(b, 10)

	var res *llnode

	for sum > 0 {
		res = &llnode{value: sum % 10, next: res}
		sum = sum / 10
	}

	return res
}

func LLToI(head *llnode, base int) int {
	res := 0

	for head != nil {
		res = res*base + head.value
		head = head.next
	}

	return res
}
