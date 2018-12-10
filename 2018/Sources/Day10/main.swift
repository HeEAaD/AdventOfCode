import Foundation
struct Point {
    var position: (x: Int, y: Int)
    let velocity: (x: Int, y: Int)

    mutating func move() {
        position.x += velocity.x
        position.y += velocity.y
    }
}

func show(points: [Point]) {
    let xs = points.map { $0.position.x }
    let ys = points.map { $0.position.y }
    let xOffset = xs.min()!
    let yOffset = ys.min()!
    let width = xs.max()! - xOffset + 1
    let height = ys.max()! - yOffset + 1

    var grid = Array(repeating: Array(repeating: false, count: width), count: height)
    for point in points {
        grid[point.position.y - yOffset][point.position.x - xOffset] = true
    }
    for row in grid {
        var line = ""
        for isPoint in row {
            line.append(isPoint ? "#" : ".")
        }
        print(line)
    }
}

var points: [Point] = input.components(separatedBy: .newlines).map { line in
    let words = line.components(separatedBy: CharacterSet(["<", " ", ",", ">"])).compactMap { Int($0) }
    assert(words.count == 4)
    return Point(position: (words[0], words[1]),
                 velocity: (words[2], words[3]))
}

var yd = Int.max
var lastPoints = points
var sec = 0
while true {
    for i in 0..<points.count {
        points[i].move()
    }
    let ys = points.map { $0.position.y }
    let newyd = ys.max()! - ys.min()!
    if newyd > yd {
        break
    }
    sec += 1
    yd = newyd
    lastPoints = points
}

print("Task 1:")
show(points: lastPoints)
print("Task 2: \(sec)")
