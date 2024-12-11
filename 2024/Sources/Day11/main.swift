let stones: [Int] = input.split(separator: " ").map { Int($0)! }

print("Answer 1:", run(stones, iterations: 25))
print("Answer 2:", run(stones, iterations: 75))

func run(_ stones: [Int], iterations: Int) -> Int {
    var stoneCounts: [Int: Int] = stones.reduce(into: [:]) {
        $0[$1, default: 0] += 1
    }

    for _ in 0..<iterations {
        var newStoneCounts: [Int: Int] = [:]

        for (stone, count) in stoneCounts {
            if stone == 0 {
                newStoneCounts[1, default: 0] += count
                continue
            }
            let digits = String(stone).map { String($0) }
            if digits.count.isMultiple(of: 2) {
                newStoneCounts[Int(digits[0..<digits.count/2].joined())!, default: 0] += count
                newStoneCounts[Int(digits[digits.count/2..<digits.count].joined())!, default: 0] += count
            } else {
                newStoneCounts[stone * 2024, default: 0] += count
            }
        }

        stoneCounts = newStoneCounts
    }

    return stoneCounts.values.reduce(0, +)
}
