day_files = filter(contains(r"^day[0-9][0-9].jl$"), readdir("src"))
println(day_files)
for day in day_files
    include("$day")
end

import .Day01, .Day02, .Day03, .Day04, .Day05, .Day06, .Day07, .Day08, .Day09

function time_all()
    modules = [Day01, Day02, Day03, Day04, Day05, Day06, Day07, Day08, Day09]

    times = []

    for mod in modules
        push!(times, @elapsed mod.part1())
        push!(times, @elapsed mod.part2())
    end

    times
end

times = time_all()

println(times)
println(sum(times))
