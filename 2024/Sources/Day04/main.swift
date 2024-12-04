let grid: [[Character]] = input
    .split(whereSeparator: \.isNewline)
    .map { $0.map { $0 } }

var sum = 0
for y in 0..<grid.count {
    for x in 0..<grid[y].count where grid[y][x] == "X" {
        if checkD(x: x, y: y) {
            sum += 1
        }
        if checkU(x: x, y: y) {
            sum += 1
        }
        if checkL(x: x, y: y) {
            sum += 1
        }
        if checkR(x: x, y: y) {
            sum += 1
        }
        if checkLD(x: x, y: y) {
            sum += 1
        }
        if checkLU(x: x, y: y) {
            sum += 1
        }
        if checkRD(x: x, y: y) {
            sum += 1
        }
        if checkRU(x: x, y: y) {
            sum += 1
        }
    }
}

print("Answer 1:", sum)

var sum2 = 0
for y in 1..<grid.count - 1 {
    for x in 1..<grid[y].count - 1 where grid[y][x] == "A" {
        let isXMAS = (
            (grid[y-1][x-1] == "M" && grid[y+1][x+1] == "S") || (grid[y-1][x-1] == "S" && grid[y+1][x+1] == "M")
        ) && (
            (grid[y+1][x-1] == "M" && grid[y-1][x+1] == "S") || (grid[y+1][x-1] == "S" && grid[y-1][x+1] == "M")
        )
        if isXMAS {
            sum2 += 1
        }
    }
}

print("Answer 2:", sum2)

// MARK: - Methods

func checkL(x: Int, y: Int) -> Bool {
    guard x >= 3 else { return false }
    return grid[y][x] == "X" && grid[y][x-1] == "M" && grid[y][x-2] == "A" && grid[y][x-3] == "S"
}

func checkR(x: Int, y: Int) -> Bool {
    guard x < grid[y].count - 3 else { return false }
    return grid[y][x] == "X" && grid[y][x+1] == "M" && grid[y][x+2] == "A" && grid[y][x+3] == "S"
}

func checkU(x: Int, y: Int) -> Bool {
    guard y >= 3 else { return false }
    return grid[y][x] == "X" && grid[y-1][x] == "M" && grid[y-2][x] == "A" && grid[y-3][x] == "S"
}

func checkD(x: Int, y: Int) -> Bool {
    guard y < grid.count - 3 else { return false }
    return grid[y][x] == "X" && grid[y+1][x] == "M" && grid[y+2][x] == "A" && grid[y+3][x] == "S"
}

func checkLU(x: Int, y: Int) -> Bool {
    guard x >= 3 && y >= 3 else { return false }
    return grid[y][x] == "X" && grid[y-1][x-1] == "M" && grid[y-2][x-2] == "A" && grid[y-3][x-3] == "S"
}

func checkRU(x: Int, y: Int) -> Bool {
    guard x < grid[y].count - 3 && y >= 3 else { return false }
    return grid[y][x] == "X" && grid[y-1][x+1] == "M" && grid[y-2][x+2] == "A" && grid[y-3][x+3] == "S"
}

func checkLD(x: Int, y: Int) -> Bool {
    guard x >= 3 && y < grid.count - 3 else { return false }
    return grid[y][x] == "X" && grid[y+1][x-1] == "M" && grid[y+2][x-2] == "A" && grid[y+3][x-3] == "S"
}

func checkRD(x: Int, y: Int) -> Bool {
    guard x < grid[y].count - 3 && y < grid.count - 3 else { return false }
    return grid[y][x] == "X" && grid[y+1][x+1] == "M" && grid[y+2][x+2] == "A" && grid[y+3][x+3] == "S"
}
