func findStart(grid: [[Character]]) -> (x: Int, y: Int) {
    for (y, row) in grid.enumerated() {
        for (x, cell) in row.enumerated() where cell == "S" {
            return (x, y)
        }
    }
    fatalError()
}

let grid = input
    .split(separator: "\n")
    .map { Array($0) }
var isLoopGrid = Array(repeating: Array(repeating: false, count: grid[0].count), count: grid.count)

var pos = findStart(grid: grid)

isLoopGrid[pos.y][pos.x] = true

var steps = 0
enum Direction {
    case west, north, east, south
}
var direction = Direction.east

if pos.x > 0 && ["-", "L", "F"].contains(grid[pos.y][pos.x - 1]) {
    pos.x -= 1
    steps += 1
    direction = .west
} else if pos.y > 0 && ["|", "7", "F"].contains(grid[pos.y - 1][pos.x]) {
    pos.y -= 1
    steps += 1
    direction = .north
} else if pos.x < grid[pos.y].count - 1 && ["-", "7", "J"].contains(grid[pos.y][pos.x + 1]) {
    pos.x += 1
    steps += 1
    direction = .east
} else if pos.y < grid.count - 1 && ["|", "L", "J"].contains(grid[pos.y + 1][pos.x]) {
    pos.y += 1
    steps += 1
    direction = .south
}

isLoopGrid[pos.y][pos.x] = true

while grid[pos.y][pos.x] != "S" {
    switch (direction, grid[pos.y][pos.x]) {
    case (.west, "-"):
        pos.x -= 1
        steps += 1
    case (.west, "L"):
        pos.y -= 1
        steps += 1
        direction = .north
    case (.west, "F"):
        pos.y += 1
        steps += 1
        direction = .south
    case (.west, _):
        fatalError()

    case (.north, "|"):
        pos.y -= 1
        steps += 1
    case (.north, "7"):
        pos.x -= 1
        steps += 1
        direction = .west
    case (.north, "F"):
        pos.x += 1
        steps += 1
        direction = .east
    case (.north, _):
        fatalError()

    case (.east, "-"):
        pos.x += 1
        steps += 1
    case (.east, "J"):
        pos.y -= 1
        steps += 1
        direction = .north
    case (.east, "7"):
        pos.y += 1
        steps += 1
        direction = .south
    case (.east, _):
        fatalError()

    case (.south, "|"):
        pos.y += 1
        steps += 1
    case (.south, "J"):
        pos.x -= 1
        steps += 1
        direction = .west
    case (.south, "L"):
        pos.x += 1
        steps += 1
        direction = .east
    case (.south, _):
        fatalError()
    }
    isLoopGrid[pos.y][pos.x] = true
}

print("Answer 1:", steps / 2)

var grid2x = Array(repeating: Array(repeating: Character("."), count: grid[0].count * 2 + 2), count: grid.count * 2 + 2)

for y in 0..<grid.count {
    for x in 0..<grid[y].count where isLoopGrid[y][x] {
        switch grid[y][x] {
        case "S":
            grid2x[y * 2 + 1][x * 2 + 1] = "S"
        case "-":
            grid2x[y * 2 + 1][x * 2] = "-"
            grid2x[y * 2 + 1][x * 2 + 1] = "-"
            grid2x[y * 2 + 1][x * 2 + 2] = "-"
        case "|":
            grid2x[y * 2][x * 2 + 1] = "|"
            grid2x[y * 2 + 1][x * 2 + 1] = "|"
            grid2x[y * 2 + 2][x * 2 + 1] = "|"
        case "7":
            grid2x[y * 2 + 1][x * 2] = "-"
            grid2x[y * 2 + 1][x * 2 + 1] = "7"
            grid2x[y * 2 + 2][x * 2 + 1] = "|"
        case "J":
            grid2x[y * 2 + 1][x * 2] = "-"
            grid2x[y * 2 + 1][x * 2 + 1] = "J"
            grid2x[y * 2][x * 2 + 1] = "|"
        case "F":
            grid2x[y * 2 + 2][x * 2 + 1] = "|"
            grid2x[y * 2 + 1][x * 2 + 1] = "F"
            grid2x[y * 2 + 1][x * 2 + 2] = "-"
        case "L":
            grid2x[y * 2][x * 2 + 1] = "|"
            grid2x[y * 2 + 1][x * 2 + 1] = "L"
            grid2x[y * 2 + 1][x * 2 + 2] = "-"
        default:
            break
        }
    }
}

var stack = [(x: 0, y: 0)]
while !stack.isEmpty {
    let pos = stack.removeLast()
    guard pos.y >= 0, pos.y < grid2x.count,
          pos.x >= 0, pos.x < grid2x[pos.y].count,
          grid2x[pos.y][pos.x] == "."
    else { continue }
    grid2x[pos.y][pos.x] = "O"
    stack.append((x: pos.x - 1, y: pos.y))
    stack.append((x: pos.x + 1, y: pos.y))
    stack.append((x: pos.x, y: pos.y - 1))
    stack.append((x: pos.x, y: pos.y + 1))
}

var enclosedSum = 0
for y in 0..<grid.count {
    for x in 0..<grid[y].count where grid2x[y * 2 + 1][x * 2 + 1] == "." {
        enclosedSum += 1
    }
}

print("Answer 2:", enclosedSum)
