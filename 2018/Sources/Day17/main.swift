import Foundation
enum Type: String, Equatable {
    case empty = "."
    case solid = "#"
    case movingWater = "|"
    case restingWater = "~"
}

var grid = Array(repeating: Array(repeating: Type.empty, count: 600), count: 10)

for line in input.split(separator: "\n").sorted() {
    assert(line.contains(".."))
    //    print(line)
    let ints = line.replacingOccurrences(of: "x", with: "")
        .replacingOccurrences(of: "y", with: "")
        .replacingOccurrences(of: "=", with: "")
        .replacingOccurrences(of: ",", with: "")
        .replacingOccurrences(of: ".", with: " ")
        .split(separator: " ")
        .compactMap { Int($0) }

    assert(ints.count == 3)

    if line.first! == "x" {
        let x = ints[0]
        for y in ints[1]...ints[2] {
            while y >= grid.count {
                grid.append(Array(repeating: Type.empty, count: 600))
            }
            grid[y][x] = .solid
        }
    } else if line.first! == "y" {
        let y = ints[0]
        while y >= grid.count {
            grid.append(Array(repeating: Type.empty, count: 600))
        }
        for x in ints[1]...ints[2] {
            grid[y][x] = .solid
        }
    } else {
        fatalError()
    }
}

func print(_ grid: [[Type]]) {
    let (minX, maxX) = grid.reduce((Int.max, Int.min), { result, row in
        return (
            min(result.0, row.firstIndex(where: { $0 != .empty }) ?? Int.max),
            max(result.1, row.lastIndex(where: { $0 != .empty }) ?? Int.min)
        )
    })

    for row in grid {
        var line = ""
        for e in row[minX...maxX] {
            line.append(e.rawValue)
        }
        print(line)
    }
    print()
}

grid[0][500] = .movingWater

func fill() -> (Int, Int) {
    print(grid)

    let solidSumBeforeFill = grid.flatMap { $0 }.reduce(0) { $0 + ($1 == .solid ? 1 : 0) }

    var changed = false
    repeat {
        changed = false
        for y in 0..<grid.count - 1 {
            for x in 0..<grid[y].count where grid[y][x] == .movingWater {
                if grid[y + 1][x] == .empty {
                    // fall
                    grid[y + 1][x] = .movingWater
                    changed = true
                    continue
                }

                guard grid[y + 1][x] == .restingWater || grid[y + 1][x] == .solid else {
                    continue
                }

                var ox = -1
                while grid[y][x + ox] == .empty || grid[y][x + ox] == .movingWater {
                    // spread left
                    if grid[y][x + ox] != .movingWater {
                        precondition(grid[y][x + ox] != .solid)
                        grid[y][x + ox] = .movingWater
                        changed = true
                    }
                    if grid[y + 1][x + ox] == .empty || grid[y + 1][x + ox] == .movingWater {
                        // overflow to the right
                        precondition(grid[y][x + ox] != .solid)
                        grid[y][x + ox] = .movingWater
                        break
                    }
                    ox -= 1
                }

                ox = 1
                while grid[y][x + ox] == .empty || grid[y][x + ox] == .movingWater {
                    // spread right
                    if grid[y][x + ox] != .movingWater {
                        precondition(grid[y][x + ox] != .solid)
                        grid[y][x + ox] = .movingWater
                        changed = true
                    }
                    if grid[y + 1][x + ox] == .empty || grid[y + 1][x + ox] == .movingWater {
                        // overflow to the right
                        precondition(grid[y][x + ox] != .solid)
                        grid[y][x + ox] = .movingWater
                        break
                    }
                    ox += 1
                }

//                print("after fill")
//                print(grid)
                var shouldRest = true
                var shouldRestRange = x..<x + 1
                ox = -1
                while grid[y][x + ox] == .movingWater && shouldRest {
                    // check left
                    if grid[y + 1][x + ox] == .empty || grid[y + 1][x + ox] == .movingWater {
                        shouldRest = false
                        break
                    }
                    shouldRestRange = (x + ox)..<shouldRestRange.endIndex
                    ox -= 1
                }
                ox = 1
                while grid[y][x + ox] == .movingWater && shouldRest {
                    // check right
                    if grid[y + 1][x + ox] == .empty || grid[y + 1][x + ox] == .movingWater {
                        shouldRest = false
                        break
                    }
                    shouldRestRange = shouldRestRange.startIndex..<(x + ox + 1)
                    ox += 1
                }

                if shouldRest {
                    assert(shouldRestRange.startIndex > 0)
                    assert(shouldRestRange.endIndex < 1000)
                    for xr in shouldRestRange {
                        changed = true
                        precondition(grid[y][xr] != .solid)
                        grid[y][xr] = .restingWater
                    }
                }
//                print("after rest")
//                print(grid)
            }
        }
    } while changed

    print(grid)

    let solidSumAfterFill = grid.flatMap { $0 }.reduce(0) { $0 + ($1 == .solid ? 1 : 0) }
    precondition(solidSumBeforeFill == solidSumAfterFill)

    var waterSum = 0
    for y in 0..<grid.count {
        if grid[y].contains(.solid) {
            break
        }
        waterSum -= 1
    }

    for y in 0..<grid.count {
        for x in 0..<grid[y].count where grid[y][x] == .movingWater || grid[y][x] == .restingWater {
            waterSum += 1
        }
    }

    let restingWaterSum = grid.flatMap { $0 }.reduce(0) { $0 + ($1 == .restingWater ? 1 : 0) }

    return (waterSum, restingWaterSum)
}

let (waterSum, restingWaterSum) = fill()
print("Task 1: \(waterSum)")
print("Task 2: \(restingWaterSum)")
