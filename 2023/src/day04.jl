module Day04

input = read("input/day04.txt", String)

function part1()
    part1_inner(input)
end

function part1_inner(input)
    lines = split(input, '\n')
    total = 0
    lines = lines |> filter(l -> !isempty(l))
    for line in lines
        nums = split(line, ':')[2]
        (winning, ours) = split(nums, '|')
        winning = Set(map(n -> parse(Int, n), split(winning)))
        ours = map(n -> parse(Int, n), split(ours))
        count = map(n -> n in winning, ours) |> sum
        if count > 0
            score = 2^(count - 1)
            total += score
        end
    end
    total
end


function part2()
    part2_inner(input)
end

function part2_inner(input)
    lines = split(input, '\n')
    count_scores = []

    lines = lines |> filter(l -> !isempty(l))
    for line in lines
        nums = split(line, ':')[2]
        (winning, ours) = split(nums, '|')
        winning = Set(map(n -> parse(Int, n), split(winning)))
        ours = map(n -> parse(Int, n), split(ours))
        count = map(n -> n in winning, ours) |> sum
        push!(count_scores, (1, count))
    end

    for (i, (count, score)) in enumerate(count_scores)
        for j in 1:score
            (c, s) = count_scores[i+j]
            count_scores[i+j] = (c+count, s)
        end
    end

    map(t -> t[1],count_scores) |> sum
end


using Test

@testset "day 04" begin
    @test Day04.part1_inner(
        "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11") == 13
    @test Day04.part1() == 21568

    @test Day04.part2_inner(
        "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11") == 30
    @test Day04.part2() == 11827296
end
end
