let coordinates = input.split(whereSeparator: \.isNewline).map { line in
    let components = line.split(separator: ",").map { Int($0)! }
    return Point(x: components[0], y: components[1])
}

let maxXY = 70
let bytes = 1024

let start = Point(x: 0, y: 0)
let end = Point(x: maxXY, y: maxXY)

print("Answer 1:", shortesPathSteps(corrupted: Set(coordinates[0..<bytes]))!)

for bytes in (bytes + 1)...coordinates.count {
    if shortesPathSteps(corrupted: Set(coordinates[0..<bytes])) == nil {
        print("Answer 2:", "\(coordinates[bytes - 1].x),\(coordinates[bytes - 1].y)")
        break
    }
}

struct Point: Hashable {
    let x: Int
    let y: Int
}

func shortesPathSteps(corrupted: Set<Point>) -> Int? {
    var shortestPaths: [Point: Int] = [start: 0]
    var leaves: Set<Point> = [start]
    var steps: Int = 0

    while !leaves.isEmpty {
        steps += 1

        var newLeaves: Set<Point> = []
        for point in leaves {
            if point == end {
                return shortestPaths[point]
            }
            for neighbor in neighbors(of: point) {
                if corrupted.contains(neighbor) { continue }
                if let shortedPathToNeighbor = shortestPaths[neighbor] {
                    if shortedPathToNeighbor < steps {
                        continue
                    }
                    shortestPaths[neighbor] = steps
                    newLeaves.insert(neighbor)
                } else {
                    shortestPaths[neighbor] = steps
                    newLeaves.insert(neighbor)
                }
            }
        }

        if newLeaves.isEmpty {
            return nil
        }

        leaves = newLeaves
    }

    fatalError()
}

func neighbors(of point: Point) -> [Point] {
    var neighbors: [Point] = []
    if point.x > 0 { neighbors.append(Point(x: point.x - 1, y: point.y)) }
    if point.x < maxXY { neighbors.append(Point(x: point.x + 1, y: point.y)) }
    if point.y > 0 { neighbors.append(Point(x: point.x, y: point.y - 1)) }
    if point.y < maxXY { neighbors.append(Point(x: point.x, y: point.y + 1)) }
    return neighbors
}
