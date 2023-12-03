module Day03

input = read("input/day03.txt", String)

function part1()
    part1_inner(input)
end

function part1_inner(input)
    lines = input |> i -> split(i, "\n")
    issymbol(c) = !isdigit(c) && c != '.'
    current_number = ""
    sum = 0
    for (i, line) in enumerate(lines)
        isadjacent = false
        for (j, char) in enumerate(line)
            if isdigit(char)
                current_number *= char
            end

            if !isdigit(char) || j == length(line)
                if isadjacent
                    if current_number != ""
                        num = parse(Int, current_number)
                        sum += num
                    end
                end
                isadjacent = false
                current_number = ""
            end

            isadjacent |= issymbol(char)
            if j + 1 < length(line)
                isadjacent |= issymbol(line[j+1])
            end
            if i - 1 > 0
                isadjacent |= issymbol(lines[i-1][j])
            end
            if i + 1 < length(lines)
                isadjacent |= issymbol(lines[i+1][j])
            end
            if i - 1 > 0 && j + 1 < length(line)
                isadjacent |= issymbol(lines[i-1][j+1])
            end
            if i + 1 < length(lines) && j + 1 < length(line)
                isadjacent |= issymbol(lines[i+1][j+1])
            end
        end
    end
    sum
end


function part2()
    part2_inner(input)
end

function part2_inner(input)
    lines = input |> i -> split(i, "\n")
    isgear(c) = c == '*'
    sum = 0

    function get_number(line, index)
        if !isdigit(line[index])
            return ""
        end
        current_number = ""
        while index > 1 && isdigit(line[index-1])
            index -= 1
        end
        while index <= length(line) && isdigit(line[index])
            current_number *= line[index]
            index += 1
        end
        current_number
    end

    for (i, line) in enumerate(lines)
        for (j, char) in enumerate(line)
            if !isgear(char)
                continue
            end

            count = 0
            ratio = 1
            r = get_number(line, j+1)
            if r != ""
                count += 1
                ratio *= parse(Int, r)
            end
            l = get_number(line, j-1)
            if l != ""
                count += 1
                ratio *= parse(Int, l)
            end

            if i > 1
                above = lines[i-1]
                if isdigit(above[j])
                    t = get_number(above, j)
                    if t != ""
                        count += 1
                        ratio *= parse(Int, t)
                    end
                else
                    tl = get_number(above, j-1)
                    if tl != ""
                        count += 1
                        ratio *= parse(Int, tl)
                    end
                    tr = get_number(above, j+1)
                    if tr != ""
                        count += 1
                        ratio *= parse(Int, tr)
                    end
                end
            end

            if i <= length(lines)
                below = lines[i+1]
                if isdigit(below[j])
                    b = get_number(below, j)
                    if b != ""
                        count += 1
                        ratio *= parse(Int, b)
                    end
                else
                    bl = get_number(below, j-1)
                    if bl != ""
                        count += 1
                        ratio *= parse(Int, bl)
                    end
                    br = get_number(below, j+1)
                    if br != ""
                        count += 1
                        ratio *= parse(Int, br)
                    end
                end
            end

            if count == 2
                sum += ratio
            end
        end
    end
    sum
end


using Test

@testset "day 03" begin
    @test Day03.part1_inner(
        "467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...\$.*....
.664.598..") == 4361
    @test Day03.part1() == 498559

    @test Day03.part2_inner(
        "467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...\$.*....
.664.598..") == 467835
    @test Day03.part2() == 72246648
end
end
