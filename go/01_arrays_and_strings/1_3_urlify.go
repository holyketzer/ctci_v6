package arrays

// n - target str length (after replacing ' ' with '%20')
// B: time = O(n), mem = O(1)
func UrlifyB(str []rune, srcN int) []rune {
	// Left pointer to iterate
	p1 := srcN - 1

	targetN := srcN

	for i := 0; i < srcN; i++ {
		if str[i] == ' ' {
			targetN += 2
		}
	}

	// Right pointer to iterate
	p2 := targetN - 1

	for p2 >= 0 {
		if str[p1] == ' ' {
			str[p2-2] = '%'
			str[p2-1] = '2'
			str[p2-0] = '0'

			p1 -= 1
			p2 -= 3
		} else {
			str[p2] = str[p1]
			p1 -= 1
			p2 -= 1
		}
	}

	return str
}
