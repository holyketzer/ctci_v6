package arrays

import (
	"math"
)

// n - str length
// A: time = O(n), mem = O(1)
func OneWayA(s1 string, s2 string) bool {
	sizeDiff := math.Abs(float64(len(s1) - len(s2)))

	if sizeDiff > 1 {
		return false
	} else if sizeDiff == 0 {
		delta := 0

		for i := 0; i < len(s1); i++ {
			if s1[i] != s2[i] {
				delta += 1
			}
		}

		return delta == 1
	} else {
		long, short := s2, s1

		if len(s1) > len(s2) {
			long, short = s1, s2
		}

		s := 0
		l := 0
		delta := 0

		for s < len(short) && l < len(long) {
			if short[s] == long[l] {
				s += 1
				l += 1
			} else {
				delta += 1
				l += 1
			}
		}

		delta += len(long) - l

		return delta == 1
	}
}
