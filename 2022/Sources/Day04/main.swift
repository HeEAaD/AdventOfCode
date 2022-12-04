var sumContaining = 0
var sumOverlap = 0

for line in input.split(whereSeparator: \.isNewline) {
    let ranges = line.split(separator: ",").map {
        let range = $0.split(separator: "-").map { Int($0)! }
        return range[0]...range[1]
    }
    let lhs = ranges[0]
    let rhs = ranges[1]
    if lhs.overlaps(rhs) {
        sumOverlap += 1
        if (lhs.lowerBound >= rhs.lowerBound && lhs.upperBound <= rhs.upperBound) ||
            (rhs.lowerBound >= lhs.lowerBound && rhs.upperBound <= lhs.upperBound) {
            sumContaining += 1
        }
    }
}

print("Answer 1:", sumContaining)
print("Answer 2:", sumOverlap)
