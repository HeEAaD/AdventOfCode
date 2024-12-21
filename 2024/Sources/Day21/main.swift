let codes = input.split(whereSeparator: \.isNewline).map { String($0) }
var cache: [CacheKey: Int64] = [:]

struct CacheKey: Hashable {
    let level: Int
    let maxLevel: Int
    let sequence: String
}

print("Answer 1:", calculateComplexity(code: codes, robots: 2))
print("Answer 2:", calculateComplexity(code: codes, robots: 25))

@MainActor func calculateComplexity(code: [String], robots: Int) -> Int64 {
    var complexitySum: Int64 = 0
    for code in codes {
        let intCode = Int64(code.dropLast())!
        let shortest = lengthOfShortestSequence(code: code, robots: robots)
        complexitySum += shortest * intCode
    }
    return complexitySum
}

@MainActor func lengthOfShortestSequence(code: String, robots: Int) -> Int64 {
    sequencesForCode(code).reduce(into: 0) {
        $0 += lengthOfShortestMoves(sequences: $1, level: 1, maxLevel: robots)
    }
}

@MainActor func lengthOfShortestMoves(sequences: [String], level: Int, maxLevel: Int) -> Int64 {
    var result = Int64.max
    if level == maxLevel {
        for sequence in sequences {
            let sumMinLengths = sequencesForSequence(sequence)
                .map { $0.map(\.count).min()! - 1 }
                .reduce(0, +)
            if result > sumMinLengths {
                result = Int64(sumMinLengths)
            }
        }
        return result
    }

    for sequence in sequences {
        let length: Int64
        if let cachedLength = cache[CacheKey(level: level, maxLevel: maxLevel, sequence: sequence)] {
            length = cachedLength
        } else {
            length = sequencesForSequence(sequence).map {
                lengthOfShortestMoves(sequences: $0, level: level + 1, maxLevel: maxLevel)
            }.reduce(0, +)
            cache[CacheKey(level: level, maxLevel: maxLevel, sequence: sequence)] = length
        }
        if result > length {
            result = length
        }
    }

    return result
}

func sequencesForCode(_ code: String) -> [[String]] {
    var result: [[String]] = []
    for (from, to) in zip("A" + code, code) {
        result.append(shortestMovesNumpad(from: from, to: to))
    }
    return result
}

func sequencesForSequence(_ sequence: String) -> [[String]] {
    zip(sequence, sequence.dropFirst()).map {
        shortestMovesArrowpad(from: $0, to: $1)
    }
}

func shortestMovesNumpad(from: Character, to: Character) -> [String] {
    switch (from, to) {
    case ("A", "A"):
        ["AA"]
    case ("A", "0"):
        ["A<A"]
    case ("A", "1"):
        [
            "A<^<A",
            "A^<<A",
        ]
    case ("A", "2"):
        [
            "A<^A",
            "A^<A",
        ]
    case ("A", "3"):
        [
            "A^A",
        ]
    case ("A", "4"):
        [
            "A<^<^A",
            "A<^^<A",
            "A^<<^A",
            "A^<^<A",
            "A^^<<A",
        ]
    case ("A", "5"):
        [
            "A<^^A",
            "A^<^A",
            "A^^<A",
        ]
    case ("A", "6"):
        [
            "A^^A",
        ]
    case ("A", "7"):
        [
            "A<^<^^A",
            "A<^^<^A",
            "A<^^^<A",

            "A^<<^^A",
            "A^<^<^A",
            "A^<^^<A",

            "A^^<<^A",
            "A^^<^<A",

            "A^^^<<A",
        ]
    case ("A", "8"):
        [
            "A<^^^A",
            "A^<^^A",
            "A^^<^A",
            "A^^^<A",
        ]
    case ("A", "9"):
        [
            "A^^^A",
        ]

    case ("0", "A"):
        [
            "A>A"
        ]
    case ("0", "0"):
        ["AA"]
    case ("0", "1"):
        [
            "A^<A"
        ]
    case ("0", "2"):
        [
            "A^A"
        ]
    case ("0", "3"):
        [
            "A^>A",
            "A>^A",
        ]
    case ("0", "4"):
        [
            "A^<^A",
            "A^^<A",
        ]
    case ("0", "5"):
        [
            "A^^A",
        ]
    case ("0", "6"):
        [
            "A^^>A",
            "A^>^A",
            "A>^^A",
        ]
    case ("0", "7"):
        [
            "A^<^^A",
            "A^^<^A",
            "A^^^<A",
        ]
    case ("0", "8"):
        [
            "A^^^A",
        ]
    case ("0", "9"):
        [
            "A^^^>A",
            "A^^>^A",
            "A^>^^A",
            "A>^^^A",
        ]

    case ("1", "A"):
        [
            "A>v>A",
            "A>>vA",
        ]
    case ("1", "0"):
        [
            "A>vA"
        ]
    case ("1", "1"):
        ["AA"]
    case ("1", "2"):
        [
            "A>A"
        ]
    case ("1", "3"):
        [
            "A>>A"
        ]
    case ("1", "4"):
        [
            "A^A"
        ]
    case ("1", "5"):
        [
            "A^>A",
            "A>^A",
        ]
    case ("1", "6"):
        [
            "A^>>A",
            "A>^>A",
            "A>>^A",
        ]
    case ("1", "7"):
        [
            "A^^A"
        ]
    case ("1", "8"):
        [
            "A^^>A",
            "A^>^A",
            "A>^^A",
        ]
    case ("1", "9"):
        [
            "A^^>>A",
            "A^>^>A",
            "A^>>^A",
            "A>^^>A",
            "A>^>^A",
            "A>>^^A",
        ]

    case ("2", "A"):
        [
            "Av>A",
            "A>vA",
        ]
    case ("2", "0"):
        [
            "AvA"
        ]
    case ("2", "1"):
        [
            "A<A"
        ]
    case ("2", "2"):
        ["AA"]
    case ("2", "3"):
        [
            "A>A"
        ]
    case ("2", "4"):
        [
            "A<^A",
            "A^<A"
        ]
    case ("2", "5"):
        [
            "A^A"
        ]
    case ("2", "6"):
        [
            "A^>A",
            "A>^A"
        ]
    case ("2", "7"):
        [
            "A<^^A",
            "A^<^A",
            "A^^<A",
        ]
    case ("2", "8"):
        [
            "A^^A",
        ]
    case ("2", "9"):
        [
            "A^^>A",
            "A^>^A",
            "A>^^A",
        ]

    case ("3", "A"):
        [
            "AvA",
        ]
    case ("3", "0"):
        [
            "A<vA",
            "Av<A"
        ]
    case ("3", "1"):
        [
            "A<<A",
        ]
    case ("3", "2"):
        [
            "A<A",
        ]
    case ("3", "3"):
        ["AA"]
    case ("3", "4"):
        [
            "A<<^A",
            "A<^<A",
            "A^<<A",
        ]
    case ("3", "5"):
        [
            "A<^A",
            "A^<A",
        ]
    case ("3", "6"):
        [
            "A^A",
        ]
    case ("3", "7"):
        [
            "A<<^^A",
            "A<^<^A",
            "A<^^<A",
            "A^<<^A",
            "A^<^<A",
            "A^^<<A",
        ]
    case ("3", "8"):
        [
            "A<^^A",
            "A^<^A",
            "A^^<A",
        ]
    case ("3", "9"):
        [
            "A^^A",
        ]

    case ("4", "A"):
        [
            "Av>v>A",
            "Av>>vA",
            "A>vv>A",
            "A>v>vA",
            "A>>vvA",
        ]
    case ("4", "0"):
        [
            "Av>vA",
            "A>vvA",
        ]
    case ("4", "1"):
        [
            "AvA",
        ]
    case ("4", "2"):
        [
            "Av>A",
            "A>vA",
        ]
    case ("4", "3"):
        [
            "Av>>A",
            "A>v>A",
            "A>>vA",
        ]
    case ("4", "4"):
        ["AA"]
    case ("4", "5"):
        [
            "A>A",
        ]
    case ("4", "6"):
        [
            "A>>A",
        ]
    case ("4", "7"):
        [
            "A^A",
        ]
    case ("4", "8"):
        [
            "A^>A",
            "A>^A",
        ]
    case ("4", "9"):
        [
            "A^>>A",
            "A>^>A",
            "A>>^A",
        ]

    case ("5", "A"):
        [
            "Avv>A",
            "Av>vA",
            "A>vvA",
        ]
    case ("5", "0"):
        [
            "AvvA",
        ]
    case ("5", "1"):
        [
            "A<vA",
            "Av<A",
        ]
    case ("5", "2"):
        [
            "AvA",
        ]
    case ("5", "3"):
        [
            "Av>A",
            "A>vA",
        ]
    case ("5", "4"):
        [
            "A<A",
        ]
    case ("5", "5"):
        ["AA"]
    case ("5", "6"):
        [
            "A>A"
        ]
    case ("5", "7"):
        [
            "A<^A",
            "A^<A",
        ]
    case ("5", "8"):
        [
            "A^A"
        ]
    case ("5", "9"):
        [
            "A^>A",
            "A>^A",
        ]

    case ("6", "A"):
        [
            "AvvA",
        ]
    case ("6", "0"):
        [
            "A<vvA",
            "Av<vA",
            "Avv<A",
        ]
    case ("6", "1"):
        [
            "A<<vA",
            "A<v<A",
            "Av<<A",
        ]
    case ("6", "2"):
        [
            "A<vA",
            "Av<A",
        ]
    case ("6", "3"):
        [
            "AvA",
        ]
    case ("6", "4"):
        [
            "A<<A",
        ]
    case ("6", "5"):
        [
            "A<A",
        ]
    case ("6", "6"):
        ["AA"]
    case ("6", "7"):
        [
            "A<<^A",
            "A<^<A",
            "A^<<A",
        ]
    case ("6", "8"):
        [
            "A<^A",
            "A^<A",
        ]
    case ("6", "9"):
        [
            "A^A",
        ]

    case ("7", "A"):
        [
            "Avv>v>A",
            "Avv>>vA",

            "Av>vv>A",
            "Av>v>vA",
            "Av>>vvA",

            "A>vvv>A",
            "A>vv>vA",
            "A>v>vvA",

            "A>>vvvA",
        ]
    case ("7", "0"):
        [
            "Avv>vA",
            "Av>vvA",
            "A>vvvA",
        ]
    case ("7", "1"):
        [
            "AvvA",
        ]
    case ("7", "2"):
        [
            "Avv>A",
            "Av>vA",
            "A>vvA",
        ]
    case ("7", "3"):
        [
            "Avv>>A",

            "Av>v>A",
            "Av>>vA",

            "A>vv>A",
            "A>v>vA",

            "A>>vvA",
        ]
    case ("7", "4"):
        [
            "AvA",
        ]
    case ("7", "5"):
        [
            "Av>A",
            "A>vA",
        ]
    case ("7", "6"):
        [
            "Av>>A",
            "A>v>A",
            "A>>vA",
        ]
    case ("7", "7"):
        ["AA"]
    case ("7", "8"):
        [
            "A>A",
        ]
    case ("7", "9"):
        [
            "A>>A",
        ]

    case ("8", "A"):
        [
            "Avvv>A",
            "Avv>vA",
            "Av>vvA",
            "A>vvvA",
        ]
    case ("8", "0"):
        [
            "AvvvA",
        ]
    case ("8", "1"):
        [
            "Avv<A",
            "Av<vA",
            "A<vvA",
        ]
    case ("8", "2"):
        [
            "A<<A",
        ]

    case ("8", "3"):
        [
            "Avv>A",
            "Av>vA",
            "A>vvA",
        ]
    case ("8", "4"):
        [
            "A<vA",
            "Av<A",
        ]
    case ("8", "5"):
        [
            "AvA",
        ]
    case ("8", "6"):
        [
            "Av>A",
            "A>vA",
        ]
    case ("8", "7"):
        [
            "A<A",
        ]
    case ("8", "8"):
        ["AA"]
    case ("8", "9"):
        [
            "A>A",
        ]

    case ("9", "A"):
        [
            "AvvvA"
        ]
    case ("9", "0"):
        [
            "A<vvvA",
            "Av<vvA",
            "Avv<vA",
            "Avvv<A",
        ]
    case ("9", "1"):
        [
            "A<<vvA",
            "A<v<vA",
            "A<vv<A",
            "Av<<vA",
            "Av<v<A",
            "Avv<<A",
        ]
    case ("9", "2"):
        [
            "A<vvA",
            "Av<vA",
            "Avv<A",
        ]
    case ("9", "3"):
        [
            "AvvA",
        ]
    case ("9", "4"):
        [
            "A<<vA",
            "A<v<A",
            "Av<<A",
        ]
    case ("9", "5"):
        [
            "A<vA",
            "Av<A",
        ]
    case ("9", "6"):
        [
            "AvA",
        ]
    case ("9", "7"):
        [
            "A<<A",
        ]
    case ("9", "8"):
        [
            "A<A",
        ]
    case ("9", "9"):
        ["AA"]

    default:
        fatalError("\(from) \(to) not supported")
    }
}

func shortestMovesArrowpad(from: Character, to: Character) -> [String] {
    switch (from, to) {
    case ("A", "A"), ("^", "^"), ("<", "<"), ("v", "v"), (">", ">"): ["AA"]

    case ("A", "^"): ["A<A"]
    case ("A", "<"): ["A<v<A", "Av<<A"]
    case ("A", "v"): ["A<vA", "Av<A"]
    case ("A", ">"): ["AvA"]

    case ("^", "A"): ["A>A"]
    case ("^", "<"): ["Av<A"]
    case ("^", "v"): ["AvA"]
    case ("^", ">"): ["Av>A", "A>vA"]

    case ("<", "A"): ["A>^>A", "A>>^A"]
    case ("<", "^"): ["A>^A"]
    case ("<", "v"): ["A>A"]
    case ("<", ">"): ["A>>A"]

    case ("v", "A"): ["A^>A", "A>^A"]
    case ("v", "^"): ["A^A"]
    case ("v", "<"): ["A<A"]
    case ("v", ">"): ["A>A"]

    case (">", "A"): ["A^A"]
    case (">", "^"): ["A<^A", "A^<A"]
    case (">", "<"): ["A<<A"]
    case (">", "v"): ["A<A"]

    default:
        fatalError("\(from) \(to) not supported")
    }
}
