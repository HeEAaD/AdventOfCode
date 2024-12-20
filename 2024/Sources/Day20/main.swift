let map: [[Character]] = input.split(whereSeparator: \.isNewline).map { $0.map { $0 } }
let stepsMap = calculateStepsMap(map: map)

print("Answer 1:", await cheatSumAsync(map: map, stepsMap: stepsMap, maxCheatLength: 2))
print("Answer 2:", await cheatSumAsync(map: map, stepsMap: stepsMap, maxCheatLength: 20))

// MARK: - Methods

struct Point: Hashable {
    let x: Int
    let y: Int
}

func cheatSumAsync(map: [[Character]], stepsMap: [[Int]], maxCheatLength: Int) async -> Int {
    await withTaskGroup(of: Int.self) { taskGroup in
        for y in 0..<map.count {
            taskGroup.addTask {
                var sum = 0
                for x in 0..<map[y].count where map[y][x] == "." || map[y][x] == "S" {
                    for dy in -maxCheatLength...maxCheatLength {
                        for dx in -maxCheatLength...maxCheatLength {
                            guard dx != 0 || dy != 0 else { continue }

                            let cheatEndPoint = Point(x: x + dx, y: y + dy)

                            guard cheatEndPoint.y >= 0 else { continue }
                            guard cheatEndPoint.x >= 0 else { continue }
                            guard cheatEndPoint.y < map.count else { continue }
                            guard cheatEndPoint.x < map[cheatEndPoint.y].count else { continue }
                            guard map[cheatEndPoint.y][cheatEndPoint.x] != "#" else { continue }

                            let cheatDistance: Int = abs(x - cheatEndPoint.x) + abs(y - cheatEndPoint.y)
                            guard cheatDistance <= maxCheatLength else { continue }

                            let diff = stepsMap[cheatEndPoint.y][cheatEndPoint.x] - stepsMap[y][x] - cheatDistance
                            if diff >= 100 {
                                sum += 1
                            }
                        }
                    }
                }
                return sum
            }
        }

        return await taskGroup.reduce(into: 0) { partialResult, sum in
            partialResult += sum
        }
    }
}

func calculateStepsMap(map: [[Character]]) -> [[Int]] {
    let start: Point = {
        for y in 0..<map.count {
            for x in 0..<map[y].count {
                if map[y][x] == "S" {
                    return Point(x: x, y: y)
                }
            }
        }
        fatalError()
    }()

    var stepsMap: [[Int]] = Array(repeating: Array(repeating: Int.max, count: map[0].count), count: map.count)
    stepsMap[start.y][start.x] = 0
    var leaves: Set<Point> = [start]
    var steps = 0

    while !leaves.isEmpty {
        steps += 1

        var newLeaves: Set<Point> = []
        for point in leaves {
            for neighbor in neighbors(of: point) {
                if map[neighbor.y][neighbor.x] == "#" { continue }
                let shortestPathToNeighbor = stepsMap[neighbor.y][neighbor.x]
                if shortestPathToNeighbor > steps {
                    stepsMap[neighbor.y][neighbor.x] = steps
                    newLeaves.insert(neighbor)
                }
            }
        }

        leaves = newLeaves
    }

    return stepsMap
}

func neighbors(of point: Point) -> [Point] {
    var neighbors: [Point] = []
    if point.x > 1 { neighbors.append(Point(x: point.x - 1, y: point.y)) }
    if point.x < map[0].count - 1 { neighbors.append(Point(x: point.x + 1, y: point.y)) }
    if point.y > 1 { neighbors.append(Point(x: point.x, y: point.y - 1)) }
    if point.y < map.count - 1 { neighbors.append(Point(x: point.x, y: point.y + 1)) }
    return neighbors
}
