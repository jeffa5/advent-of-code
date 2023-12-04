day_files = filter(contains(r"^day[0-9][0-9].jl$"), readdir("src"))
println(day_files)
for day in day_files
    include("$day")
end

import .Day01
@time Day01.part1()
@time Day01.part2()

import .Day02
@time Day02.part1()
@time Day02.part2()

import .Day03
@time Day03.part1()
@time Day03.part2()

import .Day04
@time Day04.part1()
@time Day04.part2()

()
