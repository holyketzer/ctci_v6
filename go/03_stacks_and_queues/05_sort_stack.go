package stacks_and_queues

// n - size of stack
// time = O(n^2) mem = O(n)
func SortStackA(s *stack) *stack {
	res := stack{}

	from := s
	to := stack{}

	for from.Empty() == false {
		max, _ := from.Peek()

		for from.Empty() == false {
			value, _ := from.Pop()
			if value > max {
				max = value
			}

			to.Push(value)
		}

		for to.Empty() == false {
			value, _ := to.Pop()

			if value == max {
				res.Push(value)
			} else {
				from.Push(value)
			}
		}
	}

	return &res
}

// time = O(n*log(n)) mem = O(n)
func SortStackB(s *stack) *stack {
	if s.Empty() {
		return s
	} else {
		min, _ := s.Peek()
		max := min
		tmp := stack{}

		value, err := s.Pop()
		for err == nil {
			if value < min {
				min = value
			}

			if value > max {
				max = value
			}

			tmp.Push(value)
			value, err = s.Pop()
		}

		return MedianSort(&tmp, min, max)
	}
}

func MedianSort(s *stack, min int, max int) *stack {
	value, _ := s.Pop()

	if s.Empty() {
		return s.Push(value)
	} else {
		middle := (max + min) / 2
		low, high := SplitStack(s.Push(value), middle)
		return MergeSorted(MedianSort(low, min, middle), MedianSort(high, middle+1, max))
	}
}

func SplitStack(s *stack, middle int) (*stack, *stack) {
	low := stack{}
	high := stack{}

	value, err := s.Pop()
	for err == nil {
		if value <= middle {
			low.Push(value)
		} else {
			high.Push(value)
		}

		value, err = s.Pop()
	}

	return &low, &high
}

func MergeSorted(low *stack, high *stack) *stack {
	reversed := stack{}

	value, err := low.Pop()
	for err == nil {
		reversed.Push(value)
		value, err = low.Pop()
	}

	value, err = high.Pop()
	for err == nil {
		reversed.Push(value)
		value, err = high.Pop()
	}

	res := stack{}

	value, err = reversed.Pop()
	for err == nil {
		res.Push(value)
		value, err = reversed.Pop()
	}

	return &res
}
