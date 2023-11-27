package main

import (
	"fmt"
	"os"
	"strconv"

	"github.com/jeffa5/aoc-19/days"
)

func main() {
	args := os.Args

	if len(args) != 3 {
		fmt.Printf("Usage: %s <day> <part>\n", args[0])
		return
	}

	d, err := strconv.Atoi(args[1])
	if err != nil {
		fmt.Println("Failed to convert day to int")
		return
	}

	p, err := strconv.Atoi(args[2])
	if err != nil {
		fmt.Println("Failed to convert part to int")
		return
	}
	if d == 0 {
		if p < 0 || p > 2 {
			fmt.Println("Part must be 0, 1 or 2")
			return
		}
	} else {
		if p != 1 && p != 2 {
			fmt.Println("Part must be 1 or 2")
			return
		}
	}

	days.Solve(d, p)
}
