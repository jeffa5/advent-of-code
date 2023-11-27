package day2

import (
	"fmt"

	"github.com/jeffa5/aoc-19/utils"
)

func Day2(p int, base string) string {
	ints := utils.ReadFileLineCSVInt(base + "2")

	switch p {
	case 1:
		ints[1] = 12
		ints[2] = 2
		utils.ExecIntCode(ints)
		return fmt.Sprintf("%d", ints[0])
	case 2:
		for n := 0; n <= 99; n++ {
			for v := 0; v <= 99; v++ {
				intsCopy := make([]int, len(ints))
				for i, it := range ints {
					intsCopy[i] = it
				}
				intsCopy[1] = n
				intsCopy[2] = v
				utils.ExecIntCode(intsCopy)
				if intsCopy[0] == 19690720 {
					return fmt.Sprintf("%d", 100*n+v)
				}
			}
		}
	}

	return ""
}
