let map: [[Character]] = input
    .split(whereSeparator: \.isNewline)
    .map { $0.map { $0 } }

var antennaPositions: [Character: [Point]] = [:]
for y in map.indices {
    for x in map[y].indices {
        let character = map[y][x]
        if character != "." {
            antennaPositions[character, default: []].append(Point(x: x, y: y))
        }
    }
}

print("Answer 1:", antiNodes1(antennaPositions: antennaPositions))
print("Answer 2:", antiNodes2(antennaPositions: antennaPositions))

// MARK: - Methods

struct Point: Hashable {
    let x: Int
    let y: Int
}

func isInMap(_ point: Point) -> Bool {
    point.x >= 0 && point.y >= 0 && point.x < map[0].count && point.y < map.count
}

func antiNodes1(antennaPositions: [Character: [Point]]) -> Int {
    var antinodesPositions: Set<Point> = []
    for (_, positions) in antennaPositions {
        for i in 0..<positions.count {
            for j in i+1..<positions.count {
                let dX = positions[j].x - positions[i].x
                let dY = positions[j].y - positions[i].y
                let antinodeA = Point(x: positions[i].x - dX, y: positions[i].y - dY)
                if isInMap(Point(x: positions[i].x - dX, y: positions[i].y - dY)) {
                    antinodesPositions.insert(antinodeA)
                }
                let antinodeB = Point(x: positions[j].x + dX, y: positions[j].y + dY)
                if isInMap(antinodeB) {
                    antinodesPositions.insert(antinodeB)
                }
            }
        }
    }
    return antinodesPositions.count
}

func antiNodes2(antennaPositions: [Character: [Point]]) -> Int {
    var antinodesPositions: Set<Point> = []
    for (_, positions) in antennaPositions {
        for i in 0..<positions.count {
            for j in i+1..<positions.count {
                let dX = positions[j].x - positions[i].x
                let dY = positions[j].y - positions[i].y
                antinodesPositions.insert(positions[i])
                antinodesPositions.insert(positions[j])
                var k = 1
                while true {
                    let antinode = Point(x: positions[i].x - dX * k, y: positions[i].y - dY * k)
                    if !isInMap(antinode) {
                        break
                    }
                    antinodesPositions.insert(antinode)
                    k += 1
                }
                k = 1
                while true {
                    let antinode = Point(x: positions[j].x + dX * k, y: positions[j].y + dY * k)
                    if !isInMap(antinode) {
                        break
                    }
                    antinodesPositions.insert(antinode)
                    k += 1
                }
            }
        }
    }
    return antinodesPositions.count
}
