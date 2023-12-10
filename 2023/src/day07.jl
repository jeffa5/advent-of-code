module Day07

input = read("input/day07.txt", String)

function part1()
    part1_inner(input)
end

function part1_inner(input)
    lines = input |> v -> split(v, "\n", keepempty=false) .|> split
    hands_with_scores = []
    type(hand) = begin
        counts = Dict()
        for c in hand
            counts[c] = get(counts, c, 0) + 1
        end
        if length(counts) == 1
            # five of a kind
            6
        elseif length(counts) == 2
            for (_, v) in counts
                if v == 4
                    # four of a kind
                    return 5
                elseif v == 3
                    # full house
                    return 4
                end
            end
        elseif length(counts) == 3
            for (_, v) in counts
                if v == 3
                    # three of a kind
                    return 3
                elseif v == 2
                    # two pair
                    return 2
                end
            end
        elseif length(counts) == 4
            1
        else
            0
        end
    end
    cards = reverse(['A', 'K', 'Q', 'J', 'T', '9', '8', '7', '6', '5', '4', '3', '2'])
    card_scores(hand) = begin
        map(c -> findall(==(c), cards)[1], collect(hand))
    end
    compare_hands((hx, _, tx, cx), (hy, _, ty, cy)) = begin
        if tx == ty
            cx < cy
        else
            tx < ty
        end
    end
    for (hand, bid) in lines
        bid = parse(Int, bid)
        typ = type(hand)
        card_score = card_scores(hand)
        push!(hands_with_scores, (hand, bid, typ, card_score))
    end
    sort!(hands_with_scores, lt=compare_hands)
    # calculate winnings
    winnings = map(x -> begin
            (i, (_, bid, _, _)) = x
            bid * i
        end, enumerate(hands_with_scores))
    sum(winnings)
end


function part2()
    part2_inner(input)
end

function part2_inner(input)
    lines = input |> v -> split(v, "\n", keepempty=false) .|> split
    hands_with_scores = []
    type(hand) = begin
        counts = Dict()
        for c in hand
            counts[c] = get(counts, c, 0) + 1
        end
        joker_count = get(counts, 'J', 0)
        has_joker = joker_count > 0

        if length(counts) - has_joker == 0
            # five of a kind
            6
        elseif length(counts) - has_joker == 1
            # five of a kind
            6
        elseif length(counts) - has_joker == 2
            s = 0
            for (_, v) in counts
                if v == 4 - joker_count
                    # four of a kind
                    s = max(s, 5)
                elseif v == 3 - joker_count
                    # full house
                    s = max(s, 4)
                end
            end
            return s
        elseif length(counts) - has_joker == 3
            s = 0
            for (_, v) in counts
                if v == 3 - joker_count
                    # three of a kind
                    s = max(s, 3)
                elseif v == 2 - joker_count
                    # two pair
                    s = max(s, 2)
                end
            end
            return s
        elseif length(counts) - joker_count == 4
            1
        else
            0
        end
    end
    cards = reverse(['A', 'K', 'Q', 'T', '9', '8', '7', '6', '5', '4', '3', '2', 'J'])
    card_scores(hand) = begin
        map(c -> findall(==(c), cards)[1], collect(hand))
    end
    compare_hands((hx, _, tx, cx), (hy, _, ty, cy)) = begin
        if tx == ty
            cx < cy
        else
            tx < ty
        end
    end
    for (hand, bid) in lines
        bid = parse(Int, bid)
        typ = type(hand)
        card_score = card_scores(hand)
        push!(hands_with_scores, (hand, bid, typ, card_score))
    end
    sort!(hands_with_scores, lt=compare_hands)
    # calculate winnings
    winnings = map(x -> begin
            (i, (_, bid, _, _)) = x
            bid * i
        end, enumerate(hands_with_scores))
    sum(winnings)
end


using Test
function test()

    @testset "day 07" begin
        @test Day07.part1_inner("32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483
") == 6440
        @test Day07.part1() == 253205868

        @test Day07.part2_inner("32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483
") == 5905
        @test Day07.part2() == 253907829
    end
end
end
