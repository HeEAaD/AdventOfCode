import math_h

/// Inspired by https://www.youtube.com/watch?v=i0kiZRUaL7s
func solveForInt(a1: Int64, b1: Int64, c1: Int64, a2: Int64, b2: Int64, c2: Int64) -> (x: Int64, y: Int64)? {
    let detA = a1 * b2 - b1 * a2

    guard detA != 0 else {
        return nil
    }

    let detAx = c1 * b2 - b1 * c2
    let detAy = a1 * c2 - c1 * a2
    let x = Double(detAx) / Double(detA)
    let y = Double(detAy) / Double(detA)

    return floor(x) == x && floor(y) == y ? (Int64(x), Int64(y)) : nil
}

var cost: Int64 = 0
var cost2: Int64 = 0

let regex = /Button A: X\+(\d+), Y\+(\d+)\nButton B: X\+(\d+), Y\+(\d+)\nPrize: X=(\d+), Y=(\d+)/
for match in input.matches(of: regex) {
    let buttonAX = Int64(match.1)!
    let buttonAY = Int64(match.2)!
    let buttonBX = Int64(match.3)!
    let buttonBY = Int64(match.4)!
    let prizeX = Int64(match.5)!
    let prizeY = Int64(match.6)!

    // buttonAX * a + buttonBX * b = prizeX
    // buttonAY * a + buttonBY * b = prizeY

    if let (a, b) = solveForInt(
        a1: buttonAX, b1: buttonBX, c1: prizeX,
        a2: buttonAY, b2: buttonBY, c2: prizeY
    ) {
        cost += a * 3 + b
    }

    if let (a, b) = solveForInt(
        a1: buttonAX, b1: buttonBX, c1: prizeX + 10_000_000_000_000,
        a2: buttonAY, b2: buttonBY, c2: prizeY + 10_000_000_000_000
    ) {
        cost2 += a * 3 + b
    }
}

print("Answer 1:", cost)
print("Answer 2:", cost2)
