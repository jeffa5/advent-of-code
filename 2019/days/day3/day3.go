package day3

import (
	"fmt"
	"math"
	"strconv"
	"strings"

	"github.com/jeffa5/aoc-19/utils"
)

func Day3(p int, base string) string {
	lines := utils.ReadFileLines(base + "3")

	if len(lines) != 2 {
		return "Expected only 2 lines"
	}

	parts := strings.Split(lines[0], ",")
	points1 := genPoints(parts)

	parts = strings.Split(lines[1], ",")
	points2 := genPoints(parts)

	var d int
	switch p {
	case 1:
		d = findClosestIntersection(points1, points2, true)
	case 2:
		d = findClosestIntersection(points1, points2, false)
	}

	return fmt.Sprintf("%d", d)
}

type Pos struct {
	x, y int
}

type Point struct {
	pos   Pos
	steps int
}

type Intersect struct {
	pos    Pos
	s1, s2 int
}

func findClosestIntersection(points1, points2 []Point, byDist bool) int {

	abs := func(a int) int {
		if a < 0 {
			return -a
		}
		return a
	}

	both := []Intersect{}

	m := make(map[Pos]Point)

	for _, p := range points1 {
		m[p.pos] = p
	}

	for _, p2 := range points2 {
		if p1, ok := m[p2.pos]; ok {
			x := abs(p1.pos.x)
			y := abs(p1.pos.y)
			both = append(both, Intersect{Pos{x, y}, p1.steps, p2.steps})
		}
	}

	dist := math.MaxUint32
	for _, i := range both {
		if byDist {
			newDist := i.pos.x + i.pos.y
			if newDist < dist {
				dist = newDist
			}
		} else {
			if i.s1+i.s2 < dist {
				dist = i.s1 + i.s2
			}
		}
	}

	return dist
}

func genPoints(parts []string) []Point {
	points := []Point{}
	point := Point{Pos{0, 0}, 0}

	for _, part := range parts {
		dir := part[0]
		s, _ := strconv.Atoi(part[1:])

		for i := 0; i < s; i++ {
			point = Point{Pos{point.pos.x, point.pos.y}, point.steps + 1}
			switch dir {
			case 'R':
				point.pos.x += 1
			case 'U':
				point.pos.y += 1
			case 'D':
				point.pos.y -= 1
			case 'L':
				point.pos.x -= 1
			}
			points = append(points, point)
		}
	}

	return points
}
