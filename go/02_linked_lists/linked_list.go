package linked_lists

// Linked List
type llnode struct {
	value int
	next  *llnode
}

func LL(arr []int) *llnode {
	var head *llnode

	for i := len(arr) - 1; i >= 0; i-- {
		value := arr[i]
		head = &llnode{value: value, next: head}
	}

	return head
}

func (head *llnode) LLAddValue(value int) *llnode {
	return head.LLAddNode(&llnode{value: value})
}

func (head *llnode) LLAddNode(node *llnode) *llnode {
	if head != nil {
		tail := head
		for tail.next != nil {
			tail = tail.next
		}

		tail.next = node
		return head
	} else {
		return node
	}
}

func (head *llnode) LLToArray() []int {
	res := []int{}
	curr := head

	for curr != nil {
		res = append(res, curr.value)
		curr = curr.next
	}

	return res
}

func (head *llnode) LLSize() int {
	n := 0

	curr := head
	for curr != nil {
		curr = curr.next
		n += 1
	}

	return n
}
