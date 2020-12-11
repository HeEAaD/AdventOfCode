enum Field: Equatable {
    case empty
    case seat(Bool)
}

let grid: [[Field]] = input.split(whereSeparator: \.isNewline)
    .map {
        $0.map {
            switch $0 {
            case ".":
                return Field.empty
            case "L":
                return Field.seat(false)
            case "#":
                return Field.seat(true)
            default:
                preconditionFailure("invalid input")
            }
        }
    }

let directions: [(r: Int, c: Int)] = [
    (-1, -1), (-1, 0), (-1, 1),
    (0, -1), (0, 1),
    (1, -1), (1, 0), (1, 1)
]

func occupiedAdjacentSeats(around: (r: Int, c: Int), grid: [[Field]]) -> Int {
    directions.reduce(into: 0) { sum, direction in
        var p = around
        p.c += direction.c
        p.r += direction.r
        if p.c >= 0 && p.r >= 0 && p.r < grid.count && p.c < grid[p.r].count && grid[p.r][p.c] == .seat(true) {
            sum += 1
        }
    }
}

func occupiedSeats(around: (r: Int, c: Int), grid: [[Field]]) -> Int {
    directions.reduce(into: 0) { sum, direction in
        var p = around
        p.c += direction.c
        p.r += direction.r
        while p.c >= 0 && p.r >= 0 && p.r < grid.count && p.c < grid[p.r].count {
            if grid[p.r][p.c] == .seat(true) {
                sum += 1
                break
            } else if grid[p.r][p.c] == .seat(false) {
                break
            }
            p.c += direction.c
            p.r += direction.r
        }
    }
}

func run(grid: [[Field]], threshold: Int, occupiedSeats: ((Int, Int), [[Field]]) -> Int) -> Int {

    func step(grid: [[Field]]) -> [[Field]] {
        var newGrid = grid

        for i in 0..<grid.count {
            for j in 0..<grid[i].count {

                switch grid[i][j] {
                case .empty:
                    continue
                case .seat(false):
                    if occupiedSeats((i, j), grid) == 0 {
                        newGrid[i][j] = .seat(true)
                    }
                case .seat(true):
                    if occupiedSeats((i, j), grid) >= threshold {
                        newGrid[i][j] = .seat(false)
                    }
                }
            }
        }

        return newGrid
    }

    var grid = grid
    while true {
        let newGrid = step(grid: grid)
        if newGrid == grid { break }
        grid = newGrid
    }

    return grid.reduce(into: 0, { $0 += $1.reduce(into: 0, {
        if $1 == .seat(true) {
            $0 += 1
        }
    })})
}

print("Answer 1: \(run(grid: grid, threshold: 4, occupiedSeats: occupiedAdjacentSeats))")
print("Answer 2: \(run(grid: grid, threshold: 5, occupiedSeats: occupiedSeats))")
