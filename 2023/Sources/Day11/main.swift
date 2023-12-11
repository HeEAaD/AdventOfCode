let grid = input.split(separator: "\n").map { $0.map { $0 == "#" }}

var emptyRows: Set<Int> = []
for y in 0..<grid.count where grid[y].allSatisfy({ !$0 }) {
    emptyRows.insert(y)
}

var emptyColumns: Set<Int> = []
for x in 0..<grid[0].count where grid.allSatisfy({ !$0[x] }) {
    emptyColumns.insert(x)
}

var stars: [(x: Int, y: Int)] = []
for y in 0..<grid.count {
    for x in 0..<grid[y].count where grid[y][x] {
        stars.append((x, y))
    }
}

var distanceSum2 = 0
var distanceSum1000000 = 0
for i in 0..<stars.count - 1 {
    for j in i + 1..<stars.count {
        var expandedX = 0
        if stars[i].x < stars[j].x {
            for x in stars[i].x + 1 ..< stars[j].x where emptyColumns.contains(x) {
                expandedX += 1
            }
        } else if stars[i].x > stars[j].x {
            for x in stars[j].x + 1 ..< stars[i].x where emptyColumns.contains(x) {
                expandedX += 1
            }
        }
        var expandedY = 0
        if stars[i].y < stars[j].y {
            for y in stars[i].y + 1 ..< stars[j].y where emptyRows.contains(y) {
                expandedY += 1
            }
        } else if stars[i].y > stars[j].y {
            for y in stars[j].y + 1 ..< stars[i].y where emptyRows.contains(y) {
                expandedY += 1
            }
        }
        let dx = abs(stars[i].x - stars[j].x)
        let dy = abs(stars[i].y - stars[j].y)
        distanceSum2 += dx + expandedX + dy + expandedY
        distanceSum1000000 += dx + expandedX * 999999 + dy + expandedY * 999999
    }
}

print("Answer 1:", distanceSum2)
print("Answer 2:", distanceSum1000000)
