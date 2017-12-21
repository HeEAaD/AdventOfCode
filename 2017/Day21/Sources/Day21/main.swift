import Foundation

let path = ((#file as NSString).deletingLastPathComponent as NSString).appendingPathComponent("input.txt")
let input = try String(contentsOfFile: path)
    .trimmingCharacters(in: .whitespacesAndNewlines)
    .components(separatedBy: .newlines)

var map2to3 = [Int: [[Bool]]]()
var map3to4 = [Int: [[Bool]]]()

func hash(grid: [[Bool]]) -> Int {
    let string = grid.joined().map { $0 ? "1" : "0" }.joined()
    return Int(string, radix: 2)!
}

func mirror(grid: [[Bool]]) -> [[Bool]] {
    return Array(grid.reversed())
}

func rotate2(grid: [[Bool]]) -> [[Bool]] {
    return [
        [grid[1][0], grid[0][0]],
        [grid[1][1], grid[0][1]]
    ]
}

func rotate3(grid: [[Bool]]) -> [[Bool]] {
    return [
        [grid[2][0], grid[1][0], grid[0][0]],
        [grid[2][1], grid[1][1], grid[0][1]],
        [grid[2][2], grid[1][2], grid[0][2]]
    ]
}

for line in input {
    let lights = line.flatMap { c -> Bool? in
        switch c {
        case "#": return true
        case ".": return false
        default: return nil
        }
    }

    if lights.count == 13 {

        var from = [
            Array(lights[0...1]),
            Array(lights[2...3])
        ]

        let to = [
            Array(lights[4...6]),
            Array(lights[7...9]),
            Array(lights[10...12])
        ]

        map2to3[hash(grid: from)] = to
        for _ in 0..<3 {
            from = rotate2(grid: from)
            map2to3[hash(grid: from)] = to
        }
        from = mirror(grid: from)
        map2to3[hash(grid: from)] = to
        for _ in 0..<3 {
            from = rotate2(grid: from)
            map2to3[hash(grid: from)] = to
        }

    } else if lights.count == 25 {

        var from = [
            Array(lights[0...2]),
            Array(lights[3...5]),
            Array(lights[6...8])
        ]

        let to = [
            Array(lights[9...12]),
            Array(lights[13...16]),
            Array(lights[17...20]),
            Array(lights[21...24])
        ]

        map3to4[hash(grid: from)] = to
        for _ in 0..<3 {
            from = rotate3(grid: from)
            map3to4[hash(grid: from)] = to
        }
        from = mirror(grid: from)
        map3to4[hash(grid: from)] = to
        for _ in 0..<3 {
            from = rotate3(grid: from)
            map3to4[hash(grid: from)] = to
        }
    } else {
        fatalError()
    }
}

precondition(map2to3.count == 16)
precondition(map3to4.count == 512)

func run(iterations: Int) -> Int {

    var grid: [[Bool]] = [
        [false, true, false],
        [false, false, true],
        [true, true, true]
    ]

    for _ in 0..<iterations {

        if grid.count % 2 == 0 {

            let newSize = grid.count / 2 * 3
            var newGrid = Array(repeating: Array(repeating: false, count: newSize), count: newSize)

            for y in stride(from: 0, to: grid.count, by: 2) {
                for x in stride(from: 0, to: grid[y].count, by: 2) {
                    let kernel: [[Bool]] = [
                        [grid[y][x], grid[y][x + 1]],
                        [grid[y + 1][x], grid[y + 1][x + 1]]
                    ]
                    let to = map2to3[hash(grid: kernel)]!

                    for newY in 0..<3 {
                        for newX in 0..<3 {
                            newGrid[newY + y / 2 * 3][newX + x / 2 * 3] = to[newY][newX]
                        }
                    }
                }
            }

            grid = newGrid

        } else if grid.count % 3 == 0 {

            let newSize = grid.count / 3 * 4
            var newGrid = Array(repeating: Array(repeating: false, count: newSize), count: newSize)

            for y in stride(from: 0, to: grid.count, by: 3) {
                for x in stride(from: 0, to: grid[y].count, by: 3) {
                    let kernel: [[Bool]] = [
                        [grid[y][x], grid[y][x + 1], grid[y][x + 2]],
                        [grid[y + 1][x], grid[y + 1][x + 1], grid[y + 1][x + 2]],
                        [grid[y + 2][x], grid[y + 2][x + 1], grid[y + 2][x + 2]]
                    ]
                    let to = map3to4[hash(grid: kernel)]!

                    for newY in 0..<4 {
                        for newX in 0..<4 {
                            newGrid[newY + y / 3 * 4][newX + x / 3 * 4] = to[newY][newX]
                        }
                    }
                }
            }

            grid = newGrid

        } else {
            fatalError()
        }
    }

    return grid.flatMap { $0 }.reduce(0, { $1 ? $0 + 1 : $0 })
}

print("Task1: \(run(iterations: 5))")
print("Task2: \(run(iterations: 18))")
