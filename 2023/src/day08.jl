module Day08

input = read("input/day08.txt", String)

function part1()
    part1_inner(input)
end

function part1_inner(input)
    lines = input |> v -> split(v, "\n", keepempty=false)
    lrs = lines[1]
    nodes = lines[2:end]
    graph = Dict()
    for node in nodes
        root, lr = split(node, " = ")
        l, r = split(replace(lr, '(' => "", ')' => ""), ", ")
        graph[root] = (l, r)
    end
    current_node = "AAA"
    iterations = 0
    for rl in Iterators.cycle(lrs)
        iterations += 1
        l, r = graph[current_node]
        if rl == 'R'
            current_node = r
        elseif rl == 'L'
            current_node = l
        else
            throw(DomainError(rl, "Expected one of 'LR'"))
        end
        if current_node == "ZZZ"
            break
        end
    end
    iterations
end


function part2()
    part2_inner(input)
end

function part2_inner(input)
    lines = input |> v -> split(v, "\n", keepempty=false)
    lrs = lines[1]
    nodes = lines[2:end]
    graph = Dict()
    for node in nodes
        root, lr = split(node, " = ")
        l, r = split(replace(lr, '(' => "", ')' => ""), ", ")
        graph[root] = (l, r)
    end
    current_nodes = [c for c in keys(graph) if endswith(c, "A")]
    letter = 0
    loop_lengths = []
    for current_node in current_nodes
        iterations = 0
        path = Dict()

        start_to_end_of_loop = 0
        start_of_loop_to_z = 0
        loop_length = 0
        start_to_start_of_loop = 0

        zs = []
        for lr in Iterators.cycle(lrs)

            lrs_offset = iterations % length(lrs)
            old_node = deepcopy(current_node)

            if endswith(current_node, "Z")
                push!(zs, (lrs_offset, current_node, iterations))
            end
            if haskey(path, (lrs_offset, old_node))
                if start_to_end_of_loop == 0
                    start_to_end_of_loop = iterations
                else
                    if endswith(current_node, "Z")
                        if start_of_loop_to_z == 0
                            start_of_loop_to_z = iterations - start_to_end_of_loop
                        else
                            # already found the z, and just found it again
                            loop_length = iterations - start_to_end_of_loop - start_of_loop_to_z
                            start_to_start_of_loop = start_to_end_of_loop - loop_length
                            break
                        end
                    end
                end
            end
            iterations += 1

            l, r = graph[current_node]
            if lr == 'R'
                current_node = r
            elseif lr == 'L'
                current_node = l
            else
                throw(DomainError(lr, "Expected one of 'LR'"))
            end
            path[(lrs_offset, old_node)] = current_node
        end
        l = letter + 'a'
        letter += 1
        # println("y = $start_to_start_of_loop + $start_of_loop_to_z + $l * $loop_length")
        # println("y = $(start_to_start_of_loop + start_of_loop_to_z) + $l * $loop_length")
        # println("y = ($l + 1) * $loop_length")
        push!(loop_lengths, loop_length)
    end

    # turns out that the input is forced to be a not very general pattern.
    # turns into each loop being at the start and going its length, then just finding the lcm
    lcm(loop_lengths...)
end


using Test
function test()

    @testset "day 08" begin
        @test Day08.part1_inner("RL

AAA = (BBB, CCC)
BBB = (DDD, EEE)
CCC = (ZZZ, GGG)
DDD = (DDD, DDD)
EEE = (EEE, EEE)
GGG = (GGG, GGG)
ZZZ = (ZZZ, ZZZ)") == 2
        @test Day08.part1_inner("LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)
") == 6
        @test Day08.part1() == 14681

        @test Day08.part2_inner("LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)") == 6
        @test Day08.part2() == 14321394058031
    end
end
end
