import Foundation

let schematics = input.components(separatedBy: "\n\n")

var locks: [[Int8]] = []
var keys: [[Int8]] = []

for schematic in schematics {
    let lines = schematic
        .split(whereSeparator: \.isNewline)
        .dropFirst()
        .map { $0.map { $0 } }
    var pins: [Int8] = Array(repeating: -1, count: lines[0].count)
    if schematic.hasPrefix("#") {
        for i in pins.indices {
            for height in lines.indices {
                if lines[height][i] == "." {
                    pins[i] = Int8(height)
                    break
                }
            }
        }
        locks.append(pins)
    } else if schematic.hasPrefix(".") {
        for i in pins.indices {
            for height in lines.indices {
                if lines[height][i] == "#" {
                    pins[i] = Int8(height)
                    break
                }
            }
        }
        keys.append(pins)
    } else {
        fatalError()
    }
}

var notOverlappingSum = 0
for lock in locks {
    for key in keys {
        if zip(lock, key).allSatisfy({ $0 <= $1 }) {
            notOverlappingSum += 1
        }
    }
}

print("Answer 1:", notOverlappingSum)
