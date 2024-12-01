let lines = input.split(whereSeparator: \.isNewline)

var leftNumbers: [Int] = []
var rightNumbers: [Int] = []

for line in lines {
    let numbers = line.split(separator: " ")
    leftNumbers.append(Int(numbers[0])!)
    rightNumbers.append(Int(numbers[1])!)
}

var totalDistance = 0
for (left, right) in zip(leftNumbers.sorted(), rightNumbers.sorted()) {
    totalDistance += abs(left - right)
}

print("Answer 1:", totalDistance)

let rightCounts: [Int: Int] = rightNumbers.reduce(into: [:]) { counts, number in
    counts[number, default: 0] += 1
}

var similarityScore = 0
for left in leftNumbers {
    similarityScore += left * rightCounts[left, default: 0]
}

print("Answer 2:", similarityScore)
