package arrays

import (
	"sort"
)

func StringToRuneSlice(s string) []rune {
	var r []rune

	for _, runeValue := range s {
		r = append(r, runeValue)
	}

	return r
}

func SortStringByCharacter(s string) string {
	r := StringToRuneSlice(s)

	sort.Slice(r, func(i, j int) bool {
		return r[i] < r[j]
	})

	return string(r)
}
