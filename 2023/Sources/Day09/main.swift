func nextValue(history: [Int]) -> (previous: Int, next: Int) {
    var differences = [history]
    var lastDifference = history
    while !lastDifference.allSatisfy({ $0 == 0 }) {
        var difference: [Int] = []
        for i in 0..<lastDifference.count - 1 {
            difference.append(lastDifference[i + 1] - lastDifference[i])
        }
        lastDifference = difference
        differences.append(difference)
    }

    var next = 0
    var previous = 0
    for i in (0..<differences.count - 1).reversed() {
        next = differences[i][differences[i].count - 1] + next
        previous = differences[i][0] - previous
    }

    return (previous, next)
}

let histories = input
    .split(separator: "\n")
    .map { $0.split(separator: " ").map { Int($0)! } }

var nextSum = 0
var previousSum = 0
for history in histories {
    let (previous, next) = nextValue(history: history)
    nextSum += next
    previousSum += previous
}

print("Answer 1:", nextSum)
print("Answer 2:", previousSum)
