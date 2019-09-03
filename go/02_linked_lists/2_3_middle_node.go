package linked_lists

// time = O(1), mem = O(1)
func DeleteMiddleA(node *llnode) {
	node.value = node.next.value
	node.next = node.next.next
}
