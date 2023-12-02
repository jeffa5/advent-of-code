module Day2

input = read("input/day02.txt", String)

function part1()
    part1_inner(input)
end

function part1_inner(input)
    nonempty(s) = !isempty(s)
    s = split(input, "\n") |> ls -> filter(nonempty, ls) |> ls -> map(l -> split(l, ": "), ls)
    gamesum = 0
    for line in s
        (game, rest) = line
        game = split(game, " ")[2]
        hands = map(v -> split(v, ", "), split(rest, "; "))
        valid = true
        for hand in hands
            for cubes in hand
                c = split(cubes, " ")
                count = parse(Int, c[1])
                colour = c[2]
                if (colour == "red" && count > 12) || (colour == "green" && count > 13) || (colour == "blue" && count > 14)
                    valid = false
                end
            end
        end
        if valid
            gamesum += parse(Int, game)
        end
    end
    gamesum
end


function part2()
    part2_inner(input)
end

function part2_inner(input)
    nonempty(s) = !isempty(s)
    s = split(input, "\n") |> ls -> filter(nonempty, ls) |> ls -> map(l -> split(l, ": "), ls)
    gamesum = 0
    for line in s
        (game, rest) = line
        game = split(game, " ")[2]
        hands = map(v -> split(v, ", "), split(rest, "; "))
        maxred = 0
        maxgreen = 0
        maxblue = 0
        for hand in hands
            for cubes in hand
                c = split(cubes, " ")
                count = parse(Int, c[1])
                colour = c[2]
                if colour == "red"
                    maxred = max(maxred, count)
                elseif colour == "green"
                    maxgreen = max(maxgreen, count)
                elseif colour == "blue"
                    maxblue = max(maxblue, count)
                end
            end
        end
        power = maxred * maxgreen * maxblue
        gamesum += power
    end
    gamesum
end


using Test

@testset "day 02" begin
    @test Day2.part1_inner(
        "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
") == 8
    @test Day2.part1() == 2476

    @test Day2.part2_inner(
        "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
") == 2286
    @test Day2.part2() == 54911
end
end
