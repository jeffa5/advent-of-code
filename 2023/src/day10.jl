module Day10

input = read("input/day10.txt", String)

function part1()
    part1_inner(input)
end

function part1_inner(input)
    lines = input |> v -> split(v, "\n", keepempty=false)
    # @show lines
    s_found = false
    sx = 0
    sy = 0
    for y in 1:length(lines)
        for x in 1:length(lines[y])
            if lines[y][x] == 'S'
                (sx, sy) = (x, y)
                s_found = true
                break
            end
        end
        if s_found
            break
        end
    end
    # @show sx, sy

    # edges out from s
    graph = Dict()
    prev = (-1, -1)
    next = (sx, sy)

    while true
        (x, y) = next
        char = lines[y][x]

        if char == 'S'
            # follow loop from s in one direction
            if prev != (x + 1, y) && x + 1 <= length(lines[y]) && lines[y][x+1] in ['-', 'J', '7', 'S']
                # east
                next = (x + 1, y)
            elseif prev != (x, y - 1) && y - 1 > 0 && lines[y-1][x] in ['|', '7', 'F', 'S']
                # north
                next = (x, y - 1)
            elseif prev != (x - 1, y) && x - 1 > 0 && lines[y][x-1] in ['-', 'L', 'F', 'S']
                # west
                next = (x - 1, y)
            elseif prev != (x, y + 1) && y + 1 <= length(lines) && lines[y+1][x] in ['|', 'L', 'J', 'S']
                # south
                next = (x, y + 1)
            end
        elseif char == '-'
            if x - 1 == prev[1]
                next = (x + 1, y)
            else
                next = (x - 1, y)
            end
        elseif char == '|'
            if y - 1 == prev[2]
                next = (x, y + 1)
            else
                next = (x, y - 1)
            end
        elseif char == '7'
            if x - 1 == prev[1]
                next = (x, y + 1)
            else
                next = (x - 1, y)
            end
        elseif char == 'F'
            if x + 1 == prev[1]
                next = (x, y + 1)
            else
                next = (x + 1, y)
            end
        elseif char == 'L'
            if x + 1 == prev[1]
                next = (x, y - 1)
            else
                next = (x + 1, y)
            end
        elseif char == 'J'
            if x - 1 == prev[1]
                next = (x, y - 1)
            else
                next = (x - 1, y)
            end
        end
        if haskey(graph, (x, y))
            break
        end
        # @show (x, y), prev, next, char
        graph[(x, y)] = next
        prev = (x, y)
    end

    # @show graph

    length(graph) // 2
end


function part2()
    part2_inner(input)
end

function part2_inner(input)
    lines = input |> v -> split(v, "\n", keepempty=false)
    # @show lines
    s_found = false
    sx = 0
    sy = 0
    for y in 1:length(lines)
        for x in 1:length(lines[y])
            if lines[y][x] == 'S'
                (sx, sy) = (x, y)
                s_found = true
                break
            end
        end
        if s_found
            break
        end
    end
    # @show sx, sy

    # edges out from s
    graph = Dict()
    prev = (-1, -1)
    next = (sx, sy)

    while true
        (x, y) = next
        char = lines[y][x]

        if char == 'S'
            # follow loop from s in one direction
            if prev != (x + 1, y) && x + 1 <= length(lines[y]) && lines[y][x+1] in ['-', 'J', '7', 'S']
                # east
                next = (x + 1, y)
            elseif prev != (x, y - 1) && y - 1 > 0 && lines[y-1][x] in ['|', '7', 'F', 'S']
                # north
                next = (x, y - 1)
            elseif prev != (x - 1, y) && x - 1 > 0 && lines[y][x-1] in ['-', 'L', 'F', 'S']
                # west
                next = (x - 1, y)
            elseif prev != (x, y + 1) && y + 1 <= length(lines) && lines[y+1][x] in ['|', 'L', 'J', 'S']
                # south
                next = (x, y + 1)
            end
        elseif char == '-'
            if x - 1 == prev[1]
                next = (x + 1, y)
            else
                next = (x - 1, y)
            end
        elseif char == '|'
            if y - 1 == prev[2]
                next = (x, y + 1)
            else
                next = (x, y - 1)
            end
        elseif char == '7'
            if x - 1 == prev[1]
                next = (x, y + 1)
            else
                next = (x - 1, y)
            end
        elseif char == 'F'
            if x + 1 == prev[1]
                next = (x, y + 1)
            else
                next = (x + 1, y)
            end
        elseif char == 'L'
            if x + 1 == prev[1]
                next = (x, y - 1)
            else
                next = (x + 1, y)
            end
        elseif char == 'J'
            if x - 1 == prev[1]
                next = (x, y - 1)
            else
                next = (x - 1, y)
            end
        end
        if haskey(graph, (x, y))
            break
        end
        # @show (x, y), prev, next, char
        graph[(x, y)] = next
        prev = (x, y)
    end

    # @show graph

    captured = 0
    for i in 1:length(lines)
        for j in 1:length(lines[1])
            if haskey(graph, (j, i))
                continue
            end
            intersections = 0
            # cast a ray out from this point
            for k in i:length(lines)
                if haskey(graph, (j, k))
                    if lines[k][j] in ['7', 'J', '|']
                        # not crossing the pipe
                        continue
                    end
                    intersections += 1
                end
            end
            if intersections % 2 == 1
                captured += 1
            end
        end
    end
    captured
end


using Test

@testset "day 10" begin
    @test Day10.part1_inner(".....
.S-7.
.|.|.
.L-J.
.....") == 4
    @test Day10.part1_inner("-L|F7
7S-7|
L|7||
-L-J|
L|-JF
") == 4
    @test Day10.part1_inner("..F7.
.FJ|.
SJ.L7
|F--J
LJ...
") == 8
    @test Day10.part1_inner("7-F7-
.FJ|7
SJLL7
|F--J
LJ.LJ
") == 8
    @test Day10.part1() == 7145

    @test Day10.part2_inner("...........
.S-------7.
.|F-----7|.
.||.....||.
.||.....||.
.|L-7.F-J|.
.|..|.|..|.
.L--J.L--J.
...........
") == 4
    @test Day10.part2_inner("...........
.S------7.
.|F----7|.
.||....||.
.||....||.
.|L-7F-J|.
.|..||..|.
.L--JL--J.
..........
") == 4
        @test Day10.part2_inner(".F----7F7F7F7F-7....
.|F--7||||||||FJ....
.||.FJ||||||||L7....
FJL7L7LJLJ||LJ.L-7..
L--J.L7...LJS7F-7L7.
....F-J..F7FJ|L7L7L7
....L7.F7||L7|.L7L7|
.....|FJLJ|FJ|F7|.LJ
....FJL-7.||.||||...
....L---J.LJ.LJLJ...
") == 8
        @test Day10.part2_inner("FF7FSF7F7F7F7F7F---7
L|LJ||||||||||||F--J
FL-7LJLJ||||||LJL-77
F--JF--7||LJLJ7F7FJ-
L---JF-JLJ.||-FJLJJ7
|F|F-JF---7F7-L7L|7|
|FFJF7L7F-JF7|JL---7
7-L-JL7||F7|L7F-7F7|
L.L7LFJ|||||FJL7||LJ
L7JLJL-JLJLJL--JLJ.L
") == 10
    @test Day10.part2() == 445
end
end
