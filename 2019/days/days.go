package days

import (
	"fmt"

	"github.com/jeffa5/aoc-19/days/day1"
	"github.com/jeffa5/aoc-19/days/day2"
	"github.com/jeffa5/aoc-19/days/day3"
)

type Day struct {
	d int
	f func(int, string) string
}

var dayMap = []Day{
	{1, day1.Day1},
	{2, day2.Day2},
	{3, day3.Day3},
}

func Solve(d, p int) {
	base := "input/day"
	if d == 0 {
		for _, d := range dayMap {
			if p == 0 {
				fmt.Printf("Day %d Part 1: %s\n", d.d, d.f(1, base))
				fmt.Printf("Day %d Part 2: %s\n", d.d, d.f(2, base))
			} else {
				fmt.Printf("Day %d Part %d: %s\n", d.d, p, d.f(p, base))
			}
		}
		return
	}

	for _, day := range dayMap {
		if day.d == d {
			fmt.Println(day.f(p, base))
		}
	}

}
