module Day12

input = read("input/day12.txt", String)

function part1()
    part1_inner(input)
end

function part1_inner(input)
    lines = input |> v -> split(v, "\n", keepempty=false)
    0
end


function part2()
    part2_inner(input)
end

function part2_inner(input)
    0
end

using Test
function test()
    @testset "day 12" begin
        @test Day12.part1_inner("???.### 1,1,3
.??..??...?##. 1,1,3
?#?#?#?#?#?#?#? 1,3,1,6
????.#...#... 4,1,1
????.######..#####. 1,6,5
?###???????? 3,2,1") == 374
        # @test Day12.part1() == 9177603

        # @test Day12.part2_inner("") == 8410
        # @test Day12.part2() == 632003913612
    end
end
end
