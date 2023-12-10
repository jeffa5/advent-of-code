module Day06

input = read("input/day06.txt", String)

function part1()
    part1_inner(input)
end

function part1_inner(input)
    lines = split(input, "\n", keepempty=false)
    times = map(v -> parse(Int, v), split(strip(split(lines[1], ":")[2])))
    distances = map(v -> parse(Int, v), split(strip(split(lines[2], ":")[2])))
    total = 1
    for i in 1:length(times)
        time = times[i]
        distance = distances[i]
        # solving for d = distance
        # 0 = -hold**2 + time * hold - distance
        # hold = (-time +- sqrt(time**2 - 4*-1*-distance)) / 2*-1
        # hold = (-time +- sqrt(time**2 - 4*distance)) / -2
        holda = (-time + sqrt(time^2 - 4 * distance)) / -2
        holdb = (-time - sqrt(time^2 - 4 * distance)) / -2
        wins = (ceil(holdb) - 1) - (floor(holda) + 1) + 1
        total *= Int(wins)
    end
    total
end


function part2()
    part2_inner(input)
end

function part2_inner(input)
    lines = split(input, "\n", keepempty=false)
    time = parse(Int, replace(strip(split(lines[1], ":")[2]), " " => ""))
    distance = parse(Int, replace(strip(split(lines[2], ":")[2]), " " => ""))
    # solving for d = distance
    # 0 = -hold**2 + time * hold - distance
    # hold = (-time +- sqrt(time**2 - 4*-1*-distance)) / 2*-1
    # hold = (-time +- sqrt(time**2 - 4*distance)) / -2
    holda = (-time + sqrt(time^2 - 4 * distance)) / -2
    holdb = (-time - sqrt(time^2 - 4 * distance)) / -2
    wins = (ceil(holdb) - 1) - (floor(holda) + 1) + 1
    wins
end


using Test
function test()

    @testset "day 06" begin
        @test Day06.part1_inner("Time:      7  15   30
Distance:  9  40  200") == 288
        @test Day06.part1() == 140220

        @test Day06.part2_inner("Time:      7  15   30
Distance:  9  40  200") == 71503
        @test Day06.part2() == 39570185
    end
end
end
