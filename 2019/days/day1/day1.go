package day1

import (
	"fmt"

	"github.com/jeffa5/aoc-19/utils"
)

func Day1(p int, base string) string {
	ints := utils.ReadFileLinesInt(base + "1")

	sum := 0

	for _, i := range ints {
		switch p {
		case 1:
			sum += calcWeight(i)
		case 2:
			sum += calcWeightWithFuel(i)
		}
	}

	return fmt.Sprintf("%d", sum)
}

func calcWeight(m int) int {
	return (m / 3) - 2
}

func calcWeightWithFuel(m int) int {
	div3 := m / 3
	w := div3 - 2
	if w > 0 {
		f := calcWeightWithFuel(w)
		return w + f
	}
	return 0
}
