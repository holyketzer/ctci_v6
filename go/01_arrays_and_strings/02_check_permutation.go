package arrays

// size of string = n

// B: time = O(n), mem = O(n)
func PermutationB(s1 string, s2 string) bool {
	if len(s1) != len(s2) {
		return false
	}

	h1 := make(map[rune]int)
	h2 := make(map[rune]int)

	for _, c := range s1 {
		if _, ok := h1[c]; ok {
			h1[c] += 1
		} else {
			h1[c] = 1
		}
	}

	for _, c := range s2 {
		if _, ok := h2[c]; ok {
			h2[c] += 1
		} else {
			h2[c] = 1
		}

	}

	for k, v := range h1 {
		if h2[k] != v {
			return false
		}
	}

	return true
}

// C: time = O(n*lon(n)), mem = O(1)
func PermutationC(s1 string, s2 string) bool {
	if len(s1) != len(s2) {
		return false
	}

	return SortStringByCharacter(s1) == SortStringByCharacter(s2)
}
