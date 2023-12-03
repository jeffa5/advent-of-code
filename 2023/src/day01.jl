module Day01

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
    mappings = [
        "one",
        "two",
        "three",
        "four",
        "five",
        "six",
        "seven",
        "eight",
        "nine",
    ]
    mapline = line -> begin
        f = missing
        for i in 1:lastindex(line)
            lin = line[i:end]
            if f === missing
                for (v, k) in enumerate(mappings)
                    if startswith(lin, k)
                        f = v
                        break
                    end
                end
                if isnumeric(lin[1])
                    f = lin[1]
                end
            end
            if f !== missing
                break
            end
        end

        l = missing
        for i in lastindex(line):-1:1
            lin = line[i:end]
            for (v, k) in enumerate(mappings)
                if startswith(lin, k)
                    l = v
                    break
                end
            end
            if isnumeric(lin[1])
                l = lin[1]
            end
            if l !== missing
                break
            end
        end
        parse(Int, "$f$l")
    end
    input |> split |> v -> map(mapline, v) |> sum
end


using Test

@testset "day 01" begin
    @test Day01.part1_inner("1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet") == 142
    @test Day01.part1() == 56506

    @test Day01.part2_inner("two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen") == 281
    @test Day01.part2() == 56017
end
end
