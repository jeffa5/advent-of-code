module Day11

input = read("input/day11.txt", String)

function part1()
    part1_inner(input)
end

function part1_inner(input)
    part2_inner(input, 2)
end


function part2()
    part2_inner(input, 1_000_000)
end

function part2_inner(input, scale)
    universe = input |> v -> split(v, "\n", keepempty=false)
    row_widths = []
    col_widths = []
    for line in universe
        if all(map(v -> v == '.', collect(line)))
            push!(row_widths, scale)
        else
            push!(row_widths, 1)
        end
    end

    for col in 1:length(universe[1])
        all = true
        for i in 1:length(universe)
            if universe[i][col] != '.'
                all = false
                break
            end
        end
        if all
            push!(col_widths, scale)
        else
            push!(col_widths, 1)
        end
    end

    positions = []
    x = 0
    for i in 1:length(universe)
        x += row_widths[i]
        y = 0
        for j in 1:length(universe[i])
            y += col_widths[j]
            if universe[i][j] == '#'
                push!(positions, (x, y))
            end
        end
    end

    path_sum = 0
    for (i, pos) in enumerate(positions)
        for other_pos in positions[i+1:end]
            len = abs(pos[1] - other_pos[1]) + abs(pos[2] - other_pos[2])
            path_sum += len
        end
    end

    path_sum
end

using Test
function test()
    @testset "day 11" begin
        @test Day11.part1_inner("...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#.....") == 374
        @test Day11.part1() == 9177603

        @test Day11.part2_inner("...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#.....", 2) == 374
        @test Day11.part2_inner("...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#.....", 10) == 1030
        @test Day11.part2_inner("...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#.....", 100) == 8410
        @test Day11.part2() == 632003913611
    end
end
end
