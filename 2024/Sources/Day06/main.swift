let lines = input.split(whereSeparator: \.isNewline)

var obstacles: Set<Point> = []
var startPosition: Point?
for y in lines.indices {
    let line = lines[y].map { $0 }
    for x in line.indices {
        if line[x] == "#" {
            obstacles.insert(Point(x: x, y: y))
        } else if line[x] == "^" {
            precondition(startPosition == nil)
            startPosition = Point(x: x, y: y)
        }
    }
}

let maxY = lines.count - 1
let maxX = lines[0].count - 1

print("Answer 1:", walk(obstacles: obstacles, startPosition: startPosition!))

var loopCount = 0
for y in 0..<lines.count {
    for x in 0..<lines[y].count {
        let additionalObstacle = Point(x: x, y: y)
        guard startPosition != additionalObstacle else { continue }
        guard !obstacles.contains(additionalObstacle) else { continue }
        if isLoop(obstacles: obstacles.union([additionalObstacle]), startPosition: startPosition!) {
            loopCount += 1
        }
    }
}
print("Answer 2:", loopCount)

// MARK: Methods
struct Point: Hashable {
    var x: Int
    var y: Int
}

struct VisitedPoint: Hashable {
    var x: Int
    var y: Int
    var directions: Direction
}

enum Direction {
    case up
    case right
    case down
    case left
}

func walk(obstacles: Set<Point>, startPosition: Point) -> Int {
    var position = startPosition
    var direction: Direction = .up
    var visited: Set<Point> = [position]

    while true {
        let nextPosition: Point
        switch direction {
        case .up: nextPosition = Point(x: position.x, y: position.y - 1)
        case .right: nextPosition = Point(x: position.x + 1, y: position.y)
        case .down: nextPosition = Point(x: position.x, y: position.y + 1)
        case .left: nextPosition = Point(x: position.x - 1, y: position.y)
        }
        if nextPosition.y < 0 || nextPosition.y > maxY || nextPosition.x < 0 || nextPosition.x > maxX {
            return visited.count
        }
        if obstacles.contains(nextPosition) {
            switch direction {
            case .up: direction = .right
            case .right: direction = .down
            case .down: direction = .left
            case .left: direction = .up
            }
        } else {
            position = nextPosition
            visited.insert(position)
        }
    }
}

func isLoop(obstacles: Set<Point>, startPosition: Point) -> Bool {
    var position = startPosition
    var direction: Direction = .up
    var visited: Set<VisitedPoint> = [VisitedPoint(x: position.x, y: position.y, directions: direction)]

    while true {
        let nextPosition: Point
        switch direction {
        case .up: nextPosition = Point(x: position.x, y: position.y - 1)
        case .right: nextPosition = Point(x: position.x + 1, y: position.y)
        case .down: nextPosition = Point(x: position.x, y: position.y + 1)
        case .left: nextPosition = Point(x: position.x - 1, y: position.y)
        }
        if nextPosition.y < 0 || nextPosition.y > maxY || nextPosition.x < 0 || nextPosition.x > maxX {
            return false
        }
        if obstacles.contains(nextPosition) {
            switch direction {
            case .up: direction = .right
            case .right: direction = .down
            case .down: direction = .left
            case .left: direction = .up
            }
        } else {
            position = nextPosition
            let nextVisitedPoint = VisitedPoint(x: position.x, y: position.y, directions: direction)
            if visited.contains(nextVisitedPoint) {
                return true
            }
            visited.insert(nextVisitedPoint)
        }
    }
}
