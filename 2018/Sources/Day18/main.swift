enum Acre: Character {
    case open = "."
    case trees = "|"
    case lumberyard = "#"
}

let grid = input.split(separator: "\n").map { line in
    line.compactMap(Acre.init)
}

func run(grid: [[Acre]], minutes: Int) -> Int {
    var grid = grid
    var knownGrids = [grid]
    for minute in 1...minutes {
        var newGrid = grid
        for y in 0..<grid.count {
            for x in 0..<grid[y].count {
                var adjacent = [Acre]()
                if y > 0 {
                    if x > 0 {
                        adjacent.append(grid[y - 1][x - 1])
                    }
                    adjacent.append(grid[y - 1][x])
                    if x < grid[y].count - 1 {
                        adjacent.append(grid[y - 1][x + 1])
                    }
                }
                if x > 0 {
                    adjacent.append(grid[y][x - 1])
                }
                if x < grid[y].count - 1 {
                    adjacent.append(grid[y][x + 1])
                }
                if y < grid.count - 1 {
                    if x > 0 {
                        adjacent.append(grid[y + 1][x - 1])
                    }
                    adjacent.append(grid[y + 1][x])
                    if x < grid.count - 1 {
                        adjacent.append(grid[y + 1][x + 1])
                    }
                }

                switch grid[y][x] {
                case .open:
                    if adjacent.filter({ $0 == .trees }).count >= 3 {
                        newGrid[y][x] = .trees
                    }
                case .trees:
                    if adjacent.filter({ $0 == .lumberyard }).count >= 3 {
                        newGrid[y][x] = .lumberyard
                    }
                case .lumberyard:
                    if !adjacent.contains(.lumberyard) || !adjacent.contains(.trees) {
                        newGrid[y][x] = .open
                    }
                }
            }
        }

        grid = newGrid

        // loop entry
        if let index = knownGrids.firstIndex(of: grid) {
            knownGrids.removeFirst(index)
            grid = knownGrids[(minutes - minute) % knownGrids.count]
            break
        }

        knownGrids.append(grid)
    }

    let treesSum = grid.flatMap { $0 }.filter { $0 == .trees }.count
    let lumberyardSum = grid.flatMap { $0 }.filter { $0 == .lumberyard }.count
    return treesSum * lumberyardSum
}

print("Task 1: \(run(grid: grid, minutes: 10))")
print("Task 2: \(run(grid: grid, minutes: 1000000000))")
