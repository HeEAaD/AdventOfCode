let input = "hxtvlmkl"

class Block {
    var group: Int?
}

typealias Grid = [[Block?]]

func calculateGrid(input: String) -> Grid {
    var grid = Grid()
    for i in 0..<128 {
        let hash = knotHash("\(input)-\(i)", radix: 2)
        let row = hash.map { $0 == "1" ? Block() : nil }
        grid.append(row)
    }
    return grid
}

let grid = calculateGrid(input: input)

func task1(grid: Grid) -> Int {
    var sum = 0
    for row in grid {
        for block in row where block != nil {
            sum += 1
        }
    }
    return sum
}

func nextFreeBlockIndex(grid: Grid) -> (Int, Int)? {
    for (i, row) in grid.enumerated() {
        if let j = row.index(where: { $0 != nil && $0?.group == nil }) {
            return (i, j)
        }
    }
    return nil
}

func mark(grid: Grid, group: Int, seed: (Int, Int)) {

    guard let block = grid[seed.0][seed.1], block.group == nil else { return }

    block.group = group

    if seed.0 > 0 {
        mark(grid: grid, group: group, seed: (seed.0 - 1, seed.1))
    }

    if seed.1 > 0 {
        mark(grid: grid, group: group, seed: (seed.0, seed.1 - 1))
    }

    if seed.0 < grid.count - 1 {
        mark(grid: grid, group: group, seed: (seed.0 + 1, seed.1))
    }

    if seed.1 < grid[seed.0].count - 1 {
        mark(grid: grid, group: group, seed: (seed.0, seed.1 + 1))
    }
}

func task2(grid: Grid) -> Int {
    var group = 0

    while true {
        if let nextSeed = nextFreeBlockIndex(grid: grid) {
            mark(grid: grid, group: group, seed: nextSeed)
            group += 1
        } else {
            return group
        }
    }
}

print("Task1: \(task1(grid: grid))")
print("Task2: \(task2(grid: grid))")
