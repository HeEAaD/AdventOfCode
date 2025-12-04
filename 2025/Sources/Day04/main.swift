func removeAccessable(grid: [[Bool]]) -> (grid: [[Bool]], removed: Int) {
    var newGrid = grid
    var removed = 0

    for y in grid.indices {
        for x in grid[y].indices where grid[y][x] {
            var adjacentPapers = 0

            if y > 0 {
                if x > 0, grid[y - 1][x - 1] {
                    adjacentPapers += 1
                }
                if grid[y - 1][x] {
                    adjacentPapers += 1
                }
                if x + 1 < grid[y].count, grid[y - 1][x + 1] {
                    adjacentPapers += 1
                }
            }
            if x > 0, grid[y][x - 1] {
                adjacentPapers += 1
            }
            if x + 1 < grid[y].count, grid[y][x + 1] {
                adjacentPapers += 1
            }
            if y + 1 < grid.count {
                if x > 0, grid[y + 1][x - 1] {
                    adjacentPapers += 1
                }
                if grid[y + 1][x] {
                    adjacentPapers += 1
                }
                if x + 1 < grid[y].count, grid[y + 1][x + 1] {
                    adjacentPapers += 1
                }
            }

            if adjacentPapers < 4 {
                removed += 1
                newGrid[y][x] = false
            }
        }
    }
    return (newGrid, removed)
}

var grid = input.split(whereSeparator: \.isNewline).map { $0.map { $0 == "@" } }
var totalRemoved = 0

let (newGrid, removed) = removeAccessable(grid: grid)
grid = newGrid
totalRemoved += removed

print("Answer 1:", totalRemoved)

while true {
    let (newGrid, removed) = removeAccessable(grid: grid)
    grid = newGrid
    totalRemoved += removed
    if removed == 0 {
        break
    }
}

print("Answer 2:", totalRemoved)
