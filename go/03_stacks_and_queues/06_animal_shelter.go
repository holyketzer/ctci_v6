package stacks_and_queues

const Cat = "cat"
const Dog = "dog"

type animal struct {
	kind string
	name string
}

func (a *animal) ToString() string {
	return a.kind + "-" + a.name
}

type animalContainer struct {
	animal *animal
	number int
}

// Linked List
type asNode struct {
	value *animalContainer
	next  *asNode
}

type asLinkedList struct {
	head *asNode
}

func (l *asLinkedList) Push(value *animalContainer) *asNode {
	return l.AddNode(&asNode{value: value})
}

func (l *asLinkedList) AddNode(node *asNode) *asNode {
	if l.head != nil {
		tail := l.head
		for tail.next != nil {
			tail = tail.next
		}

		tail.next = node
		return l.head
	} else {
		l.head = node
		return node
	}
}

func (l *asLinkedList) Pop() *animalContainer {
	if l.head != nil {
		value := l.head.value
		l.head = l.head.next
		return value
	} else {
		return nil
	}
}

func (l *asLinkedList) Empty() bool {
	return l.head == nil
}

func (l *asLinkedList) headValue() *animalContainer {
	if l.head != nil {
		return l.head.value
	} else {
		return nil
	}
}

type animalShelter struct {
	dogs   *asLinkedList
	cats   *asLinkedList
	number int
}

func NewAsLinkedList() *asLinkedList {
	return &asLinkedList{}
}

func NewAnimalShelter() *animalShelter {
	return &animalShelter{
		dogs:   NewAsLinkedList(),
		cats:   NewAsLinkedList(),
		number: 1,
	}
}

func (s *animalShelter) Enqueue(a *animal) {
	container := &animalContainer{animal: a, number: s.number}
	s.number += 1

	if a.kind == Dog {
		s.dogs.Push(container)
	} else {
		s.cats.Push(container)
	}
}

func (s *animalShelter) DequeueCat() *animal {
	if s.cats.Empty() == false {
		c := s.cats.Pop()
		return c.animal
	} else {
		return nil
	}
}

func (s *animalShelter) DequeueDog() *animal {
	if s.dogs.Empty() == false {
		c := s.dogs.Pop()
		return c.animal
	} else {
		return nil
	}
}

func (s *animalShelter) DequeueAny() *animal {
	if s.dogs.Empty() == false && s.cats.Empty() == false {
		if s.dogs.headValue().number < s.cats.headValue().number {
			return s.dogs.Pop().animal
		} else {
			return s.cats.Pop().animal
		}
	} else if s.dogs.Empty() == false {
		return s.dogs.Pop().animal
	} else if s.cats.Empty() == false {
		return s.cats.Pop().animal
	} else {
		return nil
	}
}
