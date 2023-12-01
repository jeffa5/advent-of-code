module Day1

input = read("input/day01.txt", String)

function part1()
    part1_inner(input)
end

function part1_inner(input)
    mapline(l) = filter(isnumeric, l) |> v -> first(v) * last(v)
    input |> split |> v -> map(mapline, v) |> v -> map(n -> parse(Int, n), v) |> sum
end


function part2()
    part2_inner(input)
end

function part2_inner(input)
    mappings = Dict(
        "one" => 1,
        "two" => 2,
        "three" => 3,
        "four" => 4,
        "five" => 5,
        "six" => 6,
        "seven" => 7,
        "eight" => 8,
        "nine" => 9,
    )
    mapline = line -> begin
        f = missing
        l = missing
        for i in 1:lastindex(line)
            lin = line[i:end]
            if f === missing
                for (k, v) in mappings
                    if startswith(lin, k)
                        f = v
                        break
                    end
                end
            end
            if f === missing && isnumeric(lin[1])
                f = parse(Int, lin[1])
            end

            for (k, v) in mappings
                if startswith(lin, k)
                    l = v
                    break
                end
            end
            if isnumeric(lin[1])
                l = parse(Int, lin[1])
            end
        end
        parse(Int, "$f$l")
    end
    input |> split |> v -> map(mapline, v) |> sum
end


using Test

@testset "day 01" begin
    @test Day1.part1_inner("1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet") == 142
    @test Day1.part1() == 56506

    @test Day1.part2_inner("two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen") == 281
    @test Day1.part2() == 56017
end
end
