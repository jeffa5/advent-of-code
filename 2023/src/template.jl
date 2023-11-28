function dayn_part1()
    @info "Running day n part 1"
    part = dayn_part1_inner(1)
    @info "hello part $part"
end

function dayn_part1_inner(part)
    return part
end


function dayn_part2()
    @info "Running day n part 2"
    part = dayn_part2_inner(2)
    @info "hello part $part"
end

function dayn_part2_inner(part)
    return part
end


module Tst
    import Main
    using Test

    @testset "part 1" begin
        @test Main.dayn_part1_inner(1) == 1
    end

    @testset "part 2" begin
        @test Main.dayn_part2_inner(2) == 2
    end
end
