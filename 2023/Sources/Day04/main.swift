import Foundation

var totalPoints = 0
var cardsCount = 0

var copiesLookup: [Int: Int] = [:]

for (index, line) in input.split(whereSeparator: \.isNewline).enumerated() {
    let numbersStrings = line.split(separator: ":")[1].split(separator: "|")
    let winningNumbers = numbersStrings[0].split(separator: " ")
    let numbers = numbersStrings[1].split(separator: " ")

    let matchCount = numbers.reduce(into: 0) { result, number in
        if winningNumbers.contains(number) {
            result += 1
        }
    }

    totalPoints += matchCount > 0 ? Int(pow(Double(2), Double(matchCount - 1))) : 0

    let indexCardCount = copiesLookup[index, default: 0] + 1
    cardsCount += indexCardCount

    for cardIndex in index + 1 ..< index + 1 + matchCount {
        copiesLookup[cardIndex, default: 0] += indexCardCount
    }
}

print("Answer 1:", totalPoints)
print("Answer 2:", cardsCount)
