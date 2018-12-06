struct Coord {
    let x: Int
    let y: Int
}

let coords: [Coord] = input.split(separator: "\n").map { line -> Coord in
    let words = line.split(separator: " ")
    return Coord(x: Int(words[0].dropLast())!, y: Int(words[1])!)
}

let gridWidth = coords.map { $0.x }.max()! + 1
let gridHeight = coords.map { $0.y }.max()! + 1

var grid = Array(repeating: Array(repeating: -1, count: gridWidth), count: gridHeight)

var task2AreaSize = 0
for y in 0..<grid.count {
    for x in 0..<grid[y].count {
        var minCoordsI = [0]
        grid[y][x] = 0
        var totalD = 0
        for (i, coord) in coords.enumerated() {
            let d = abs(coord.x - x) + abs(coord.y - y)
            totalD += d
            if i != 0 {
                let minD = abs(coords[minCoordsI[0]].x - x) + abs(coords[minCoordsI[0]].y - y)
                if d == minD {
                    grid[y][x] = -1
                    minCoordsI.append(i)
                } else if d < minD {
                    grid[y][x] = i
                    minCoordsI = [i]
                }
            }
        }

        if totalD < 10000 {
            task2AreaSize += 1
        }
    }
}

var finitCoordCounts = [Int: Int]()
for i in 0..<coords.count {
    finitCoordCounts[i] = 0
}

for y in 0..<grid.count {
    for x in 0..<grid[y].count where x == 0 || y == 0 || x == grid[y].count - 1 || y == grid.count - 1 {
        finitCoordCounts[grid[y][x]] = nil
    }
}

for row in grid {
    for i in row {
        if let count = finitCoordCounts[i] {
            finitCoordCounts[i] = count + 1
        }
    }
}

print("Task 1: \(finitCoordCounts.values.max()!)")
print("Task 2: \(task2AreaSize)")
