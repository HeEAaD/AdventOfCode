import Foundation

let path = #file.components(separatedBy: "/Sources/main.swift").first! + "/Input/input.txt"
let ranges: [CountableClosedRange<UInt>] = try String(contentsOfFile: path)
    .components(separatedBy: .newlines)
    .filter { $0 != "" }
    .map { line in
        let uints = line.components(separatedBy: "-").map { UInt($0)! }
        return uints[0]...uints[1]
    }
    .sorted { l, r in l.lowerBound < r.lowerBound }

func firstNotInRange(ranges: [CountableClosedRange<UInt>]) -> UInt {
    var notInRange: UInt = 0
    for range in ranges {
        if range.lowerBound > notInRange {
            return notInRange
        }

        if range.upperBound > notInRange {
            notInRange = range.upperBound + 1
        }
    }
    return 0
}

func countNotInRange(ranges: [CountableClosedRange<UInt>]) -> UInt {
    var count: UInt = 0
    var notInRange: UInt = 0
    for range in ranges {
        if range.lowerBound > notInRange {
            count += range.lowerBound - notInRange
        }

        if range.upperBound > notInRange {
            notInRange = range.upperBound + 1
        }
    }
    return count
}

let task1 = firstNotInRange(ranges: ranges)
print("Task1: \(task1)") // 31053880

let task2 = countNotInRange(ranges: ranges)
print("Task2: \(task2)") // 117
