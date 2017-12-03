enum Direction {
    case l, r, u, d
}

typealias Position = (x: Int, y: Int)

func move(p: Position, d: Direction, grid: [[Int]]) -> (p: Position, d: Direction) {

    var p = p
    var d = d

    switch d {
    case .r where grid[p.y - 1][p.x] == 0:
        d = .u
        p.y -= 1
    case .r:
        p.x += 1
    case .u where grid[p.y][p.x - 1] == 0:
        d = .l
        p.x -= 1
    case .u:
        p.y -= 1
    case .l where grid[p.y + 1][p.x] == 0:
        d = .d
        p.y += 1
    case .l:
        p.x -= 1
    case .d where grid[p.y][p.x + 1] == 0:
        d = .r
        p.x += 1
    case .d:
        p.y += 1
    }

    return (p: p, d: d)
}

func task1(target: Int) -> Int {

    var grid = [[Int]](repeating: [Int](repeating: 0, count: 1000), count: 1000)
    let startP = (x: 500, y: 500)

    var d = Direction.r
    var p = startP
    grid[p.y][p.x] = 1
    p.x += 1
    grid[p.y][p.x] = 2

    for i in 3...target {
        (p, d) = move(p: p, d: d, grid: grid)
        grid[p.y][p.x] = i
    }

    return abs(p.x - startP.x) + abs(p.y - startP.y)
}

print("Task 1: \(task1(target: 325489))")

func task2(target: Int) -> Int {

    var grid = [[Int]](repeating: [Int](repeating: 0, count: 1000), count: 1000)
    let startP = (x: 500, y: 500)

    var d = Direction.r
    var p = startP
    grid[p.y][p.x] = 1
    p.x += 1
    grid[p.y][p.x] = 1

    for _ in 3...target {
        (p, d) = move(p: p, d: d, grid: grid)

        let value = grid[p.y - 1][p.x - 1] +
                grid[p.y - 1][p.x] +
                grid[p.y - 1][p.x + 1] +
                grid[p.y][p.x - 1] +
                grid[p.y][p.x + 1] +
                grid[p.y + 1][p.x - 1] +
                grid[p.y + 1][p.x] +
                grid[p.y + 1][p.x + 1]

        if value >= target {
            return value
        }

        grid[p.y][p.x] = value
    }

    fatalError()
}

print("Task 2: \(task2(target: 325489))")
