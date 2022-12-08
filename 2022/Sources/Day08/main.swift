struct Coord: Hashable {
    let x: Int
    let y: Int
}

var grid: [[Int8]] = input
    .split(whereSeparator: \.isNewline)
    .map { $0.map { Int8(String($0))! } }

var treeCoords: Set<Coord> = []

for y in 0..<grid.count {
    var maxHeight = Int8(-1)
    for x in 0 ..< grid[y].count where grid[y][x] > maxHeight {
        treeCoords.insert(Coord(x: x, y: y))
        maxHeight = grid[y][x]
        if maxHeight == 9 {
            break
        }
    }
    maxHeight = -1
    for x in (0 ..< grid[y].count).reversed() where grid[y][x] > maxHeight {
        treeCoords.insert(Coord(x: x, y: y))
        maxHeight = grid[y][x]
        if maxHeight == 9 {
            break
        }
    }
}

for x in 0..<grid[0].count {
    var maxHeight = Int8(-1)
    for y in 0 ..< grid.count where grid[y][x] > maxHeight {
        treeCoords.insert(Coord(x: x, y: y))
        maxHeight = grid[y][x]
        if maxHeight == 9 {
            break
        }
    }
    maxHeight = -1
    for y in (0 ..< grid.count).reversed() where grid[y][x] > maxHeight {
        treeCoords.insert(Coord(x: x, y: y))
        maxHeight = grid[y][x]
        if maxHeight == 9 {
            break
        }
    }
}

var maxScenicScoreProduct = 0
for treeCoord in treeCoords {
    // skip edges, because scenicScoreProduct would be zero
    guard
        treeCoord.x > 0,
        treeCoord.y > 0,
        treeCoord.x < grid[0].count - 1,
        treeCoord.y < grid.count - 1
    else { continue }

    var scenicScoreProduct = 1

    // Look right
    var scenicScoreForDirection = 0
    for x in treeCoord.x + 1 ..< grid[treeCoord.y].count {
        scenicScoreForDirection += 1
        if grid[treeCoord.y][x] >= grid[treeCoord.y][treeCoord.x] {
            break
        }
    }

    guard scenicScoreForDirection > 0 else { continue }
    scenicScoreProduct *= scenicScoreForDirection

    // Look left
    scenicScoreForDirection = 0
    for x in (0 ..< treeCoord.x).reversed() {
        scenicScoreForDirection += 1
        if grid[treeCoord.y][x] >= grid[treeCoord.y][treeCoord.x] {
            break
        }
    }

    guard scenicScoreForDirection > 0 else { continue }
    scenicScoreProduct *= scenicScoreForDirection

    // Look up
    scenicScoreForDirection = 0
    for y in (0 ..< treeCoord.y).reversed() {
        scenicScoreForDirection += 1
        if grid[y][treeCoord.x] >= grid[treeCoord.y][treeCoord.x] {
            break
        }
    }

    guard scenicScoreForDirection > 0 else { continue }
    scenicScoreProduct *= scenicScoreForDirection

    // Look down
    scenicScoreForDirection = 0
    for y in treeCoord.y + 1 ..< grid.count {
        scenicScoreForDirection += 1
        if grid[y][treeCoord.x] >= grid[treeCoord.y][treeCoord.x] {
            break
        }
    }
    scenicScoreProduct *= scenicScoreForDirection

    if scenicScoreProduct > maxScenicScoreProduct {
        maxScenicScoreProduct = scenicScoreProduct
    }
}

print("Answer 1:", treeCoords.count)
print("Answer 2:", maxScenicScoreProduct)
