let cardOrder: [Character: Int] = [
    "2": 2,
    "3": 3,
    "4": 4,
    "5": 5,
    "6": 6,
    "7": 7,
    "8": 8,
    "9": 9,
    "T": 10,
    "J": 11,
    "Q": 12,
    "K": 13,
    "A": 14
]

let cardOrder2: [Character: Int] = [
    "J": 1,
    "2": 2,
    "3": 3,
    "4": 4,
    "5": 5,
    "6": 6,
    "7": 7,
    "8": 8,
    "9": 9,
    "T": 10,
    "Q": 12,
    "K": 13,
    "A": 14
]

enum Rank: Comparable {
    case highCard
    case onePair
    case twoPair
    case threeOfAKind
    case fullHouse
    case fourOfAKind
    case fiveOfAKind

    init(lookup: [Character: Int]) {
        let counts = lookup.values
        switch counts.count {
        case 1:
            self = .fiveOfAKind
        case 2:
            self = counts.contains(4) ? .fourOfAKind : .fullHouse
        case 3:
            self = counts.contains(3) ? .threeOfAKind : .twoPair
        case 4:
            self = .onePair
        default:
            self = .highCard
        }
    }
}

struct Hand {
    let cards: [Character]
    let bid: Int
    let rank: Rank
    let rank2: Rank
}

let hands: [Hand] = input.split(separator: "\n").map { line -> Hand in
    let components = line.split(separator: " ")
    let cards = Array(components[0])

    var lookup: [Character: Int] = [:]
    for card in cards {
        lookup[card, default: 0] += 1
    }

    var lookup2 = lookup
    if lookup.count > 1 && lookup["J"] != nil {
        let (card, count) = lookup
            .sorted(by: { $0.value < $1.value })
            .last(where: { $0.key != "J" })!
        lookup2[card] = count + lookup["J"]!
        lookup2["J"] = nil
    }

    return Hand(
        cards: cards,
        bid: Int(components[1])!,
        rank: .init(lookup: lookup),
        rank2: .init(lookup: lookup2)
    )
}

var result = 0
hands
    .sorted { lhs, rhs in
        if lhs.rank != rhs.rank {
            return lhs.rank < rhs.rank
        }

        for i in 0..<5 {
            let lhsOrder = cardOrder[lhs.cards[i]]!
            let rhsOrder = cardOrder[rhs.cards[i]]!

            if lhsOrder != rhsOrder {
                return lhsOrder < rhsOrder
            }
        }
        return false
    }
    .enumerated()
    .forEach { index, hand in
        result += hand.bid * (index + 1)
    }

print("Answer 1:", result)

result = 0
hands
    .sorted { lhs, rhs in
        if lhs.rank2 != rhs.rank2 {
            return lhs.rank2 < rhs.rank2
        }

        for i in 0..<5 {
            let lhsOrder = cardOrder2[lhs.cards[i]]!
            let rhsOrder = cardOrder2[rhs.cards[i]]!

            if lhsOrder != rhsOrder {
                return lhsOrder < rhsOrder
            }
        }
        return false
    }
    .enumerated()
    .forEach { index, hand in
        result += hand.bid * (index + 1)
    }
print("Answer 2:", result)
