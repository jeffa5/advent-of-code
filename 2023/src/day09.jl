
module Day09

input = read("input/day09.txt", String)

function part1()
    part1_inner(input)
end

function part1_inner(input)
    lines = input |> v -> split(v, "\n", keepempty=false)
    histories = map(v -> map(v -> parse(Int, v), split(v)), lines)
    predictions = 0
    for history in histories
        diff = history
        prediction = diff[end]
        while any(map(v -> v != 0, diff))
            for i in 1:(length(diff)-1)
                diff[i] = diff[i+1] - diff[i]
            end
            pop!(diff)
            prediction += diff[end]
        end
        predictions += prediction
    end
    predictions
end


function part2()
    part2_inner(input)
end

function part2_inner(input)
    lines = input |> v -> split(v, "\n", keepempty=false)
    histories = map(v -> map(v -> parse(Int, v), split(v)), lines)
    predictions = 0
    for history in histories
        diff = history
        left_side = []
        while any(map(v -> v != 0, diff))
            push!(left_side, diff[1])
            for i in 1:(length(diff)-1)
                diff[i] = diff[i+1] - diff[i]
            end
            pop!(diff)
        end
        prediction = 0
        for l in reverse(left_side)
            prediction = l - prediction
        end
        predictions += prediction
    end
    predictions
end


using Test

@testset "day 09" begin
    @test Day09.part1_inner("0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45") == 114
    @test Day09.part1() == 1681758908

    @test Day09.part2_inner("0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45") == 2
    # @test Day09.part2() == 14321394058031
end
end
