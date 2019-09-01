package arrays

// n - str length, a - str alphabet size
// B: time = O(n), mem = O(a)
func PalindromePermutationB(str string) bool {
	h := map[rune]int{}

	for _, c := range str {
		if c != ' ' {
			if _, ok := h[c]; ok {
				h[c] += 1
			} else {
				h[c] = 1
			}
		}
	}

	oddPairs := 0

	for _, c := range h {
		if c%2 > 0 {
			oddPairs += 1
		}
	}

	return oddPairs <= 1
}

// C: time = O(n * lon(n)), mem = O(1)
func PalindromePermutationC(str string) bool {
	str = SortStringByCharacter(str)

	oddPairs := 0
	lastChar := str[0]
	lastCharCount := 1

	for i := 1; i < len(str); i++ {
		if str[i] == lastChar {
			lastCharCount += 1
		} else {
			if lastCharCount%2 > 0 && lastChar != ' ' {
				oddPairs += 1
			}

			lastChar = str[i]
			lastCharCount = 1
		}
	}

	if lastCharCount%2 > 0 && lastChar != ' ' {
		oddPairs += 1
	}

	return oddPairs <= 1
}
