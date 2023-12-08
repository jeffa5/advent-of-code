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
    vec_graph = []
    vec_indices = []
    graph_indices = Dict()
    for (k, v) in graph
        push!(vec_indices, k)
        graph_indices[k] = length(vec_indices)
    end
    for (k, (l, r)) in graph
        push!(vec_graph, (graph_indices[l], graph_indices[r]))
    end
    println(vec_graph)
    println(vec_indices)
    println(graph_indices)

    current_nodes = [v for (k, v) in graph_indices if endswith(k, "A")]
    println(current_nodes)
    iterations = 0
    for rl in Iterators.cycle(lrs)
        iterations += 1
        for (i, current_node) in enumerate(current_nodes)
            l, r = vec_graph[current_node]
            if rl == 'R'
                current_nodes[i] = r
            elseif rl == 'L'
                current_nodes[i] = l
            else
                throw(DomainError(rl, "Expected one of 'LR'"))
            end
        end
        count = 0
        for n in current_nodes
            if endswith(vec_indices[n], "Z")
                count += 1
            end
        end
        if count == min(3, length(current_nodes))
            break
        end
        println(iterations)
    end
    println(current_nodes)
    iterations
end


using Test

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
    @test Day08.part2() == 253907829
end
end
