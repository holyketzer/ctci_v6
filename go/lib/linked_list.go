package lib

// Linked List
type LLNode struct {
	Value int
	Next  *LLNode
}

func LL(arr []int) *LLNode {
	var head *LLNode

	for i := len(arr) - 1; i >= 0; i-- {
		value := arr[i]
		head = &LLNode{Value: value, Next: head}
	}

	return head
}

func (head *LLNode) Push(value int) *LLNode {
	return head.LLAddNode(&LLNode{Value: value})
}

func (head *LLNode) LLAddValue(value int) *LLNode {
	return head.Push(value)
}

func (head *LLNode) LLAddNode(node *LLNode) *LLNode {
	if head != nil {
		tail := head
		for tail.Next != nil {
			tail = tail.Next
		}

		tail.Next = node
		return head
	} else {
		return node
	}
}

func (head *LLNode) LLToArray() []int {
	res := []int{}
	curr := head

	for curr != nil {
		res = append(res, curr.Value)
		curr = curr.Next
	}

	return res
}

func (head *LLNode) LLSize() int {
	n := 0

	curr := head
	for curr != nil {
		curr = curr.Next
		n += 1
	}

	return n
}

func (head *LLNode) Any() bool {
	return head != nil
}

func (head *LLNode) Empty() bool {
	return head == nil
}

func (head *LLNode) ToString() string {
	return SliceToString(head.LLToArray())
}
