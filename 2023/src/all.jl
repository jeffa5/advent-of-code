day_files = filter(contains(r"^day[0-9][0-9].jl$"), readdir("src"))
println(day_files)
for day in day_files
    include("$day")
end

import .Day01, .Day02, .Day03, .Day04, .Day05, .Day06, .Day07, .Day08, .Day09, .Day10

modules = [Day01, Day02, Day03, Day04, Day05, Day06, Day07, Day08, Day09, Day10]

function test_all()
    for mod in modules
        mod.test()
    end
end

function time_all()
    times = []

    for mod in modules
        t1 = @elapsed mod.part1()
        t2 = @elapsed mod.part2()
        println("$mod part 1: $t1")
        println("$mod part 2: $t2")
        push!(times, t1)
        push!(times, t2)
    end

    times
end
