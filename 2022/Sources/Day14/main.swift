import Foundation

let lines = input.split(whereSeparator: \.isNewline)
var minX = Int.max
var maxX = Int.min
var maxY = Int.min

let paths = lines.map { line in
    let components = line.components(separatedBy: " -> ").map {
        let coords = $0.split(separator: ",").map { Int($0)! }
        let x = coords[0]
        let y = coords[1]
        minX = min(x, minX)
        maxX = max(x, maxX)
        maxY = max(y, maxY)
        return (x: x, y: y)
    }
    return components
}

let floor = maxY + 2
let padding = 110
let offsetX = minX - padding

var grid: [[Bool]] = Array(
    repeating: Array(
        repeating: false,
        count: padding * 2 + maxX - offsetX
    ),
    count: floor
)

for path in paths {
    for (lineStart, lineEnd) in zip(path, path.dropFirst()) {
        if lineStart.x == lineEnd.x {
            if lineStart.y < lineEnd.y {
                for y in lineStart.y...lineEnd.y {
                    grid[y][lineStart.x - offsetX] = true
                }
            } else if lineStart.y > lineEnd.y {
                for y in lineEnd.y...lineStart.y {
                    grid[y][lineStart.x - offsetX] = true
                }
            } else {
                fatalError()
            }
        } else if lineStart.y == lineEnd.y {
            if lineStart.x < lineEnd.x {
                for x in lineStart.x...lineEnd.x {
                    grid[lineStart.y][x - offsetX] = true
                }
            } else if lineStart.x > lineEnd.x {
                for x in lineEnd.x...lineStart.x {
                    grid[lineStart.y][x - offsetX] = true
                }
            } else {
                fatalError()
            }
        } else {
            fatalError()
        }
    }
}

func run(in grid: [[Bool]], isTaskOne: Bool) -> Int {
    var grid = grid
    var units = 0
    let startX = 500
    let startY = 0
    while true {
        var x = startX
        var y = startY
        while true {
            if y == floor - 1 {
                if isTaskOne {
                    return units
                } else {
                    break
                }
            }
            if !grid[y + 1][x - offsetX] {
                y += 1
            } else {
                if !grid[y + 1][x - 1 - offsetX] {
                    x -= 1
                } else if !grid[y + 1][x + 1 - offsetX] {
                    x += 1
                } else {
                    break
                }
            }
        }
        grid[y][x - offsetX] = true
        units += 1
        if !isTaskOne && x == startX && y == startY {
            return units
        }
    }
    fatalError()
}

print("Answer 1:", run(in: grid, isTaskOne: true))
print("Answer 2:", run(in: grid, isTaskOne: false))
