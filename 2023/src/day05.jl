module Day05

input = read("input/day05.txt", String)

function part1()
    part1_inner(input)
end

function part1_inner(input)
    blocks = split(input, "\n\n", keepempty=false)
    seeds = []
    for block in blocks
        if startswith(block, "seeds: ")
            seeds = split(block, ": ")[2] |> n -> split(n, " ") |> ns -> map(v -> parse(Int, v), ns)
        else
            lines = split(block, "\n", keepempty=false)
            new_seeds = copy(seeds)
            for line in lines[2:end]
                (dest_start, source_start, range_length) = split(line, " ")
                source_start = parse(Int, source_start)
                dest_start = parse(Int, dest_start)
                range_length = parse(Int, range_length)
                for (i, seed) in enumerate(seeds)
                    if source_start <= seed <= source_start + range_length
                        new_seeds[i] = dest_start + (seed - source_start)
                    end
                end
            end
            seeds = new_seeds
        end
    end
    minimum(seeds)
end


function part2()
    part2_inner(input)
end

function part2_inner(input)
    blocks = split(input, "\n\n", keepempty=false)
    seeds = []
    for block in blocks
        if startswith(block, "seeds: ")
            inits = split(block, ": ")[2] |> n -> split(n, " ") |> ns -> map(v -> parse(Int, v), ns)
            for i in 1:2:length(inits)
                push!(seeds, (inits[i], inits[i+1]))
            end
        else
            lines = split(block, "\n", keepempty=false)
            new_seeds = []
            for line in lines[2:end]
                (dest_start, source_start, range_length) = split(line, " ")
                source_start = parse(Int, source_start)
                dest_start = parse(Int, dest_start)
                range_length = parse(Int, range_length)
                source_end = source_start + range_length - 1
                i = 1
                while i <= length(seeds)
                    (seed_start, seed_length) = seeds[i]
                    seed_end = seed_start + seed_length - 1
                    if seed_start < source_start
                        # a-b
                        #  c---d
                        if source_start <= seed_end <= source_end
                            seeds[i] = (seed_start, source_start - seed_start - 1)
                            i -= 1
                            push!(new_seeds, (dest_start, seed_end - source_start + 1))
                        end
                        #  a---b
                        #   c-d
                        if seed_end > source_end
                            seeds[i] = (seed_start, source_start - seed_start - 1)
                            i -= 1
                            push!(new_seeds, (dest_start, range_length))
                            push!(seeds, (source_end + 1, seed_end - source_end - 1))
                        end
                    elseif seed_start <= source_end
                        #  a-b
                        # c---d
                        if seed_end <= source_end
                            push!(new_seeds, (dest_start + (seed_start - source_start), seed_length))
                            filter!(s -> s[1] != seed_start, seeds)
                            i -= 1
                        end
                        #    a-b
                        # c---d
                        if seed_end > source_end
                            push!(new_seeds, (dest_start + (seed_start - source_start), source_end - seed_start))
                            seeds[i] = (source_end + 1, seed_end - source_end - 1)
                            i -= 1
                        end
                    end
                    i += 1
                end
            end
            for s in seeds
                push!(new_seeds, s)
            end
            seeds = new_seeds
        end
    end
    minimum(map(v -> v[1], seeds))
end


using Test
function test()

    @testset "day 05" begin
        @test Day05.part1_inner(
            "seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4") == 35
    @test Day05.part1() == 331445006

    @test Day05.part2_inner(
        "seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4") == 46
    @test Day05.part2() == 6472060
end
end
end
