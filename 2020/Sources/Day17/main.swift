let startSlice = input
    .split(whereSeparator: \.isNewline)
    .map { $0.map { $0 == "#" } }

let cycles = 6

// 3d
do {
    var size = startSlice.count
    var origin = cycles + 1
    let gridSize = size + cycles * 2 + 2

    var grid: [[[Bool]]] = Array(repeating:
                                    Array(repeating:
                                            Array(repeating: false,
                                                  count: gridSize),
                                          count: gridSize),
                                 count: gridSize)

    for y in 0..<startSlice.count {
        for x in 0..<startSlice[y].count {
            grid[origin][origin + y][origin + x] = startSlice[y][x]
        }
    }

    for _ in 0..<cycles {
        origin -= 1
        size += 2
        let range = origin..<origin+size
        var newGrid = grid
        for z in range {
            for y in range {
                for x in range {
                    var neighbors = 0
                    for dz in -1...1 {
                        for dy in -1...1 {
                            for dx in -1...1 where !(dz == 0 && dy == 0 && dx == 0) && grid[z + dz][y + dy][x + dx] {
                                neighbors += 1
                            }
                        }
                    }

                    if newGrid[z][y][x] {
                        newGrid[z][y][x] = neighbors == 2 || neighbors == 3
                    } else {
                        newGrid[z][y][x] = neighbors == 3
                    }
                }
            }
        }

        grid = newGrid
    }

    var active = 0
    let range = 0..<grid.count
    for z in range {
        for y in range {
            for x in range where grid[z][y][x] {
                active += 1
            }
        }
    }
    print("Answer 1: \(active)")
}

// 4d
do {
    var size = startSlice.count
    var origin = cycles + 1
    let gridSize = size + cycles * 2 + 2

    var grid: [[[[Bool]]]] = Array(repeating:
                                    Array(repeating:
                                            Array(repeating:
                                                Array(repeating: false,
                                                      count: gridSize),
                                                  count: gridSize),
                                          count: gridSize),
                                 count: gridSize)


    for y in 0..<startSlice.count {
        for x in 0..<startSlice[y].count {
            grid[gridSize / 2][gridSize / 2][origin + y][origin + x] = startSlice[y][x]
        }
    }

    for _ in 0..<cycles {
        origin -= 1
        size += 2
        let range = origin..<origin+size
        var newGrid = grid
        for w in range {
            for z in range {
                for y in range {
                    for x in range {
                        var neighbors = 0
                        for dw in -1...1 {
                            for dz in -1...1 {
                                for dy in -1...1 {
                                    for dx in -1...1 where !(dw == 0 && dz == 0 && dy == 0 && dx == 0) && grid[w + dw][z + dz][y + dy][x + dx] {
                                        neighbors += 1
                                    }
                                }
                            }
                        }

                        if newGrid[w][z][y][x] {
                            newGrid[w][z][y][x] = neighbors == 2 || neighbors == 3
                        } else {
                            newGrid[w][z][y][x] = neighbors == 3
                        }
                    }
                }
            }
        }
        grid = newGrid
    }

    var active = 0
    let range = 0..<grid.count
    for w in range {
        for z in range {
            for y in range {
                for x in range where grid[w][z][y][x] {
                    active += 1
                }
            }
        }
    }
    print("Answer 2: \(active)")
}
