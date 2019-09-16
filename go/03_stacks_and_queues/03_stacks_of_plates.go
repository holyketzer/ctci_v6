package stacks_and_queues

import (
	"bytes"
	"errors"
	"strconv"
)

type setOfStacks struct {
	height      int
	stacks      [][]int
	stacksCount int
	sizes       map[int]int
}

func NewSetOfStacks(height int) *setOfStacks {
	return &setOfStacks{
		height:      height,
		stacks:      make([][]int, 0),
		stacksCount: 0,
		sizes:       make(map[int]int),
	}
}

func (s *setOfStacks) Push(value int) *setOfStacks {
	if s.stacksCount == 0 {
		s.AddStack()
	}

	si := s.stacksCount - 1
	pos := s.sizes[si]

	s.stacks[si][pos] = value
	s.sizes[si] += 1

	if s.sizes[si] == s.height {
		s.AddStack()
	}

	return s
}

func (s *setOfStacks) CompactStack() {
	for s.stacksCount > 0 && s.sizes[s.stacksCount-1] < 1 {
		s.stacks[s.stacksCount-1] = nil
		s.stacksCount -= 1
	}
}

func (s *setOfStacks) Pop() (int, error) {
	s.CompactStack()

	if s.stacksCount > 0 {
		si := s.stacksCount - 1
		pos := s.sizes[si] - 1
		value := s.stacks[si][pos]
		// s.stacks[si][pos] = nil
		s.sizes[si] -= 1

		return value, nil
	} else {
		return -1, errors.New("All stacks are empty")
	}
}

func (s *setOfStacks) PopAt(si int) (int, error) {
	if si < s.stacksCount {
		pos := s.sizes[si] - 1
		if pos >= 0 {
			value := s.stacks[si][pos]
			// s.stacks[si][pos] = nil
			s.sizes[si] -= 1
			return value, nil
		} else {
			return -1, errors.New("All stacks are empty")
		}
	} else {
		return -1, errors.New("All stacks are empty")
	}
}

func (s *setOfStacks) ToString() string {
	res := bytes.Buffer{}

	for i := 0; i < s.stacksCount; i++ {
		stack := s.stacks[i]

		if stack != nil {
			res.WriteString("[")

			for j := 0; j < s.sizes[i]; j++ {
				res.WriteString(strconv.Itoa(stack[j]))

				if j < s.sizes[i]-1 {
					res.WriteString("]")
				}
			}
		} else {
			res.WriteString("nil")
		}

		if i < s.stacksCount-1 {
			res.WriteString("\n")
		}
	}

	return res.String()
}

func (s *setOfStacks) AddStack() {
	s.sizes[s.stacksCount] = 0

	if len(s.stacks) <= s.stacksCount {
		s.stacks = append(s.stacks, make([]int, s.height))
	} else {
		s.stacks[s.stacksCount] = make([]int, s.height)
	}

	s.stacksCount += 1
}
