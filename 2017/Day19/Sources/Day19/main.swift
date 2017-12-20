import Foundation

let path = ((#file as NSString).deletingLastPathComponent as NSString).appendingPathComponent("input.txt")
let input = try String(contentsOfFile: path)
    .trimmingCharacters(in: .newlines)
    .split(separator: "\n")

let gridWidth = input.max { $0.count < $1.count }!.count

// grid[y][x]
var grid: [[Character]] = Array(repeating: Array(repeating: Character(" "), count: gridWidth), count: input.count)

for (y, row) in input.enumerated() {
    for (x, char) in row.enumerated() {
        grid[y][x] = char
    }
}

enum Direction {
    case d, u, l, r
}

var d = Direction.d
var p = (x: grid[0].index(of: "|")!, y: 0)
var seenChars = ""
var steps = 0

while p.x >= 0, p.y >= 0, p.y < grid.count, p.x < grid[p.y].count, grid[p.y][p.x] != " " {

    let c = grid[p.y][p.x]

    if c != "-" && c != "|" && c != "+" {
        seenChars.append(c)
    }

    if c == "+" {
        if p.x + 1 < grid[p.y].count && grid[p.y][p.x + 1] != " " && d != .l {
            d = .r
        } else if p.x > 0 && grid[p.y][p.x - 1] != " " && d != .r {
            d = .l
        } else if p.y + 1 < grid.count && grid[p.y + 1][p.x] != " " && d != .u {
            d = .d
        } else if p.y > 0 && grid[p.y - 1][p.x] != " " && d != .d {
            d = .u
        }
    }

    switch d {
    case .d: p.y += 1
    case .l: p.x -= 1
    case .r: p.x += 1
    case .u: p.y -= 1
    }

    steps += 1
}

print("Task1: \(seenChars)")
print("Task2: \(steps)")
