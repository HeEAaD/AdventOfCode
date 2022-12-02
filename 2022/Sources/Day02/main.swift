var scoreTask1 = 0
var scoreTask2 = 0

for line in input.split(whereSeparator: \.isNewline) {
    // 1 for Rock, 2 for Paper, and 3 for Scissors
    // A for Rock, B for Paper, and C for Scissors
    // X for Rock, Y for Paper, and Z for Scissors
    // X means you need to lose, Y means you need to end the round in a draw, and Z means you need to win
    switch line {
    case "A Y":
        scoreTask1 += 6 + 2
        scoreTask2 += 3 + 1
    case "B Z":
        scoreTask1 += 6 + 3
        scoreTask2 += 6 + 3
    case "C X":
        scoreTask1 += 6 + 1
        scoreTask2 += 0 + 2

    case "A X":
        scoreTask1 += 3 + 1
        scoreTask2 += 0 + 3
    case "B Y":
        scoreTask1 += 3 + 2
        scoreTask2 += 3 + 2
    case "C Z":
        scoreTask1 += 3 + 3
        scoreTask2 += 6 + 1

    case "A Z":
        scoreTask1 += 0 + 3
        scoreTask2 += 6 + 2
    case "B X":
        scoreTask1 += 0 + 1
        scoreTask2 += 0 + 1
    case "C Y":
        scoreTask1 += 0 + 2
        scoreTask2 += 3 + 3
    default:
        fatalError()
    }
}

print("Answer 1:", scoreTask1)
print("Answer 2:", scoreTask2)
