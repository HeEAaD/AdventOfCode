import Foundation

let path = ((#file as NSString).deletingLastPathComponent as NSString).appendingPathComponent("input.txt")
let input = try String(contentsOfFile: path)
    .trimmingCharacters(in: .whitespacesAndNewlines)
    .components(separatedBy: .newlines)

enum Direction {
    case u, l, r, d
}

enum InfectState {
    case clean, weakend, infected, flagged
}

var initialGrid = Array(repeatElement(Array(repeatElement(InfectState.clean, count: 500)), count: 500))
let insertOffset = (x: initialGrid[0].count / 2, y: initialGrid.count / 2)
let initialP = (x: insertOffset.x + input[0].count / 2, y: insertOffset.y + input.count / 2)

for i in 0..<input.count {

    let parsed = input[i].flatMap { c -> InfectState? in
        switch c {
        case "#": return InfectState.infected
        case ".": return InfectState.clean
        default: fatalError()
        }
    }

    initialGrid[i + insertOffset.y].insert(contentsOf: parsed, at: insertOffset.x)
}

func task1() -> Int {
    var grid = initialGrid
    var direction = Direction.u
    var p = initialP

    var count = 0

    for _ in 0..<10_000 {

        switch (direction, grid[p.y][p.x]) {
        case (.u, .infected): direction = .r
        case (.r, .infected): direction = .d
        case (.d, .infected): direction = .l
        case (.l, .infected): direction = .u
        case (.u, .clean): direction = .l
        case (.r, .clean): direction = .u
        case (.d, .clean): direction = .r
        case (.l, .clean): direction = .d
        default: fatalError()
        }

        switch grid[p.y][p.x] {
        case .clean:
            count += 1
            grid[p.y][p.x] = .infected
        case .infected:
            grid[p.y][p.x] = .clean
        default:
            fatalError()
        }

        switch direction {
        case .u: p.y -= 1
        case .d: p.y += 1
        case .l: p.x -= 1
        case .r: p.x += 1
        }
    }

    return count
}

func task2() -> Int {
    var grid = initialGrid
    var direction = Direction.u
    var p = initialP

    var count = 0

    for _ in 0..<10000000 {

        switch (direction, grid[p.y][p.x]) {
        case (_, .weakend): break
        case (.u, .infected): direction = .r
        case (.r, .infected): direction = .d
        case (.d, .infected): direction = .l
        case (.l, .infected): direction = .u
        case (.u, .clean): direction = .l
        case (.r, .clean): direction = .u
        case (.d, .clean): direction = .r
        case (.l, .clean): direction = .d
        case (.u, .flagged): direction = .d
        case (.r, .flagged): direction = .l
        case (.d, .flagged): direction = .u
        case (.l, .flagged): direction = .r
        }

        switch grid[p.y][p.x] {
        case .clean:
            grid[p.y][p.x] = .weakend
        case .weakend:
            grid[p.y][p.x] = .infected
            count += 1
        case .infected:
            grid[p.y][p.x] = .flagged
        case .flagged:
            grid[p.y][p.x] = .clean
        }

        switch direction {
        case .u: p.y -= 1
        case .d: p.y += 1
        case .l: p.x -= 1
        case .r: p.x += 1
        }
    }

    return count
}

print("Task1: \(task1())")
print("Task2: \(task2())")
