struct Point: Hashable {
    let x: Int
    let y: Int
}

let map: [[Character]] = input.split(whereSeparator: \.isNewline).map { $0.map { $0 } }

var seen: Set<Point> = []
var sum = 0
var sum2 = 0
for y in map.indices {
    for x in map.indices {
        let seed = Point(x: x, y: y)

        if seen.contains(seed) { continue }

        let area = squares(seed: seed)
        sum += area.count * parimeter(of: area)
        sum2 += area.count * sidesSum(of: area)
        seen.formUnion(area)
    }
}

print("Answer 1:", sum)
print("Answer 2:", sum2)

// MARK: - Methods

func squares(seed: Point) -> Set<Point> {
    let label = map[seed.y][seed.x]
    var stack: [Point] = [seed]
    var seen: Set<Point> = [seed]
    while let point = stack.popLast() {
        seen.insert(point)
        for neighbor in neighbors(of: point) {
            if map[neighbor.y][neighbor.x] == label, !seen.contains(neighbor) {
                stack.append(neighbor)
            }
        }
    }
    return seen
}

func parimeter(of area: Set<Point>) -> Int {
    area.reduce(into: 0) { parimeter, square in
        let neighbors = neighbors(of: square)
        for neighbor in neighbors where !area.contains(neighbor) {
            parimeter += 1
        }
        parimeter += 4 - neighbors.count
    }
}

func sidesSum(of area: Set<Point>) -> Int {
    var sum: Int = 0
    for point in area {
        let x = point.x
        let y = point.y
        // Left sides
        if x <= 0 || !area.contains(Point(x: x - 1, y: y)) {
            if y > 0 {
                //  o
                // ox
                //
                if !area.contains(Point(x: x, y: y - 1)) {
                    sum += 1
                // x
                // ox
                } else if area.contains(Point(x: x - 1, y: y - 1)) {
                    sum += 1
                }
            } else {
                sum += 1
            }
        }

        // Right sides
        if x >= map[0].count || !area.contains(Point(x: x + 1, y: y)) {
            if y > 0 {
                // o
                // xo
                //
                if !area.contains(Point(x: x, y: y - 1)) {
                    sum += 1
                //  x
                // xo
                } else if area.contains(Point(x: x + 1, y: y - 1)) {
                    sum += 1
                }
            } else {
                sum += 1
            }
        }

        // Top sides
        if y <= 0 || !area.contains(Point(x: x, y: y - 1)) {
            if x > 0 {
                //  o
                // ox
                //
                if !area.contains(Point(x: x - 1, y: y)) {
                    sum += 1
                // xo
                //  x
                } else if area.contains(Point(x: x - 1, y: y - 1)) {
                    sum += 1
                }
            } else {
                sum += 1
            }
        }

        // Bottom sides
        if y >= map.count || !area.contains(Point(x: x, y: y + 1)) {
            if x > 0 {
                // ox
                //  o
                if !area.contains(Point(x: x - 1, y: y)) {
                    sum += 1
                //  x
                // xo
                } else if area.contains(Point(x: x - 1, y: y + 1)) {
                    sum += 1
                }
            } else {
                sum += 1
            }
        }
    }
    return sum
}

func neighbors(of point: Point) -> Set<Point> {
    var neighbors: Set<Point> = []
    if point.y > 0 { neighbors.insert(Point(x: point.x, y: point.y - 1)) }
    if point.y < map.count - 1 { neighbors.insert(Point(x: point.x, y: point.y + 1)) }
    if point.x > 0 { neighbors.insert(Point(x: point.x - 1, y: point.y)) }
    if point.x < map[point.y].count - 1 { neighbors.insert(Point(x: point.x + 1, y: point.y)) }
    return neighbors
}
