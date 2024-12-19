import Foundation

let inputLines = input.split(whereSeparator: \.isNewline)
let patterns: Set<String> = Set(inputLines[0].components(separatedBy: ", "))
let designs: [String] = inputLines.dropFirst().map { String($0) }

var isPossibleLookup: [String: Bool] = [:]
var optionsLookup: [String: Int] = [:]

var sumPossibleDesigns = 0
for design in designs where isPossibleDesign(design) {
    sumPossibleDesigns += 1
    isPossibleLookup[design] = true
}

print("Answer 1:", sumPossibleDesigns)

for design in isPossibleLookup.filter(\.value).keys {
    optionsLookup[design] = countOptions(of: design)
}

var sumOptions = 0
for design in designs where isPossibleLookup[design] == true {
    sumOptions += countOptions(of: design)
}
print("Answer 2:", sumOptions)

@MainActor func isPossibleDesign(_ design: String) -> Bool {
    if let isPossible = isPossibleLookup[design] {
        return isPossible
    }

    if patterns.contains(design) {
        isPossibleLookup[design] = true
        return true
    }

    for pattern in patterns where design.hasPrefix(pattern) {
        let designWithoutPrefix = String(design.dropFirst(pattern.count))
        if isPossibleDesign(designWithoutPrefix) {
            isPossibleLookup[design] = true
            return true
        }
    }
    isPossibleLookup[design] = false
    return false
}

@MainActor func countOptions(of design: String) -> Int {
    if let count = optionsLookup[design] {
        return count
    }

    var count = 0
    for pattern in patterns {
        if design == pattern {
            count += 1
            continue
        }
        if design.hasPrefix(pattern) {
            let designWithoutPrefix = String(design.dropFirst(pattern.count))
            count += countOptions(of: designWithoutPrefix)
        }
    }

    optionsLookup[design] = count
    return count
}
