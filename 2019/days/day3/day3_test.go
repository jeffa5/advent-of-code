package day3

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestClosestIntersect(t *testing.T) {
	a := assert.New(t)

	tests := []struct {
		a []string
		b []string
		e int
	}{
		{
			a: []string{"R8", "U5", "L5", "D3"},
			b: []string{"U7", "R6", "D4", "L4"},
			e: 6,
		},
		{
			a: []string{"R75", "D30", "R83", "U83", "L12", "D49", "R71", "U7", "L72"},
			b: []string{"U62", "R66", "U55", "R34", "D71", "R55", "D58", "R83"},
			e: 159,
		},
		{
			a: []string{"R98", "U47", "R26", "D63", "R33", "U87", "L62", "D20", "R33", "U53", "R51"},
			b: []string{"U98", "R91", "D20", "R16", "D67", "R40", "U7", "R15", "U6", "R7"},
			e: 135,
		},
	}

	for _, tt := range tests {
		p1 := genPoints(tt.a)
		p2 := genPoints(tt.b)

		o := findClosestIntersection(p1, p2, true)

		a.Equal(tt.e, o)
	}
}

func TestClosestIntersect2(t *testing.T) {
	a := assert.New(t)

	tests := []struct {
		a []string
		b []string
		e int
	}{
		{
			a: []string{"R8", "U5", "L5", "D3"},
			b: []string{"U7", "R6", "D4", "L4"},
			e: 30,
		},
		{
			a: []string{"R75", "D30", "R83", "U83", "L12", "D49", "R71", "U7", "L72"},
			b: []string{"U62", "R66", "U55", "R34", "D71", "R55", "D58", "R83"},
			e: 610,
		},
		{
			a: []string{"R98", "U47", "R26", "D63", "R33", "U87", "L62", "D20", "R33", "U53", "R51"},
			b: []string{"U98", "R91", "D20", "R16", "D67", "R40", "U7", "R15", "U6", "R7"},
			e: 410,
		},
	}

	for _, tt := range tests {
		p1 := genPoints(tt.a)
		p2 := genPoints(tt.b)

		o := findClosestIntersection(p1, p2, false)

		a.Equal(tt.e, o)
	}
}

func TestGenPoints(t *testing.T) {
	a := assert.New(t)

	tests := []struct {
		a []string
		e []Point
	}{
		{
			a: []string{"R3"},
			e: []Point{Point{1, 0, 1}, Point{2, 0, 2}, Point{3, 0, 3}},
		},
		{
			a: []string{"U3"},
			e: []Point{Point{0, 1, 1}, Point{0, 2, 2}, Point{0, 3, 3}},
		},
	}

	for _, tt := range tests {
		p1 := genPoints(tt.a)

		a.Equal(tt.e, p1)
	}
}
