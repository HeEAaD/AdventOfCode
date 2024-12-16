let grid: [[Character]] = input
    .split(whereSeparator: \.isNewline)
    .map { $0.map { $0 } }

let lines = input.split(whereSeparator: \.isNewline)

var walls: [[Bool]] = []
var start: Point!
var end: Point!

for y in lines.indices {
    let line = lines[y].map { $0 }
    var wallRow: [Bool] = []
    for x in line.indices {
        switch line[x] {
        case "#":
            wallRow.append(true)
        case ".":
            wallRow.append(false)
        case "S":
            start = Point(x: x, y: y)
            wallRow.append(false)
        case "E":
            end = Point(x: x, y: y)
            wallRow.append(false)
        default:
            fatalError()
        }
    }
    walls.append(wallRow)
}

let startPath = Path(start: start, startDirection: .e)
var stack: [Path] = [startPath]
var bestPaths: [[BestPathsMulti]] = Array(
    repeating: Array(repeating: BestPathsMulti(n: [], e: [], s: [], w: []), count: walls[0].count),
    count: walls.count
)
bestPaths[start.y][start.x] = BestPathsMulti(n: [], e: [startPath], s: [], w: [])

while let path = stack.popLast() {
    if !isWallAhead(path.position, path.direction) {
        var pathForward = path
        pathForward.add(.forward)
        addToStackIfNeeded(&stack, bestPaths: &bestPaths, path: pathForward)
    }

    if !isWallOnLeft(path.position, path.direction) {
        var pathLeft = path
        pathLeft.add(.turnLeft)
        addToStackIfNeeded(&stack, bestPaths: &bestPaths, path: pathLeft)
    }

    if !isWallOnRight(path.position, path.direction) {
        var pathRight = path
        pathRight.add(.turnRight)
        addToStackIfNeeded(&stack, bestPaths: &bestPaths, path: pathRight)
    }
}

let bestPathsPaths: [Path] = [
    bestPaths[end.y][end.x].n,
    bestPaths[end.y][end.x].e,
    bestPaths[end.y][end.x].s,
    bestPaths[end.y][end.x].w,
]
.filter { !$0.isEmpty }
.min { $0.first!.score < $1.first!.score }!

precondition(Set(bestPathsPaths.map(\.score)).count == 1)

print("Answer 1:", bestPathsPaths.first!.score)
print("Answer 2:", visited(of: bestPathsPaths).count)

// MARK: - Methods

struct Point: Hashable {
    var x: Int
    var y: Int
}

struct Path {
    let start: Point
    let startDirection: Direction

    private(set) var position: Point
    private(set) var direction: Direction = .e
    private(set) var score: Int = 0
    private(set) var steps: [Step] = []

    init(start: Point, startDirection: Direction) {
        self.start = start
        self.startDirection = startDirection
        self.position = start
    }

    mutating func add(_ step: Step) {
        score += step.score
        steps.append(step)
        switch step {
        case .forward:
            switch direction {
            case .n: position.y -= 1
            case .e: position.x += 1
            case .s: position.y += 1
            case .w: position.x -= 1
            }
        case .turnLeft:
            switch direction {
            case .n: direction = .w
            case .e: direction = .n
            case .s: direction = .e
            case .w: direction = .s
            }
        case .turnRight:
            switch direction {
            case .n: direction = .e
            case .e: direction = .s
            case .s: direction = .w
            case .w: direction = .n
            }
        }
    }
}

enum Step {
    case forward
    case turnLeft, turnRight

    var score: Int {
        return switch self {
        case .forward: 1
        case .turnLeft, .turnRight: 1000
        }
    }
}

enum Direction {
    case n, e, s, w
}

struct BestPaths {
    var n: Path?
    var e: Path?
    var s: Path?
    var w: Path?
}

struct BestPathsMulti {
    var n: [Path]
    var e: [Path]
    var s: [Path]
    var w: [Path]
}

@MainActor func isWallAhead(_ point: Point, _ direction: Direction) -> Bool {
    var point = point
    switch direction {
    case .n: point.y -= 1
    case .s: point.y += 1
    case .w: point.x -= 1
    case .e: point.x += 1
    }
    return walls[point.y][point.x]
}

@MainActor func isWallOnLeft(_ point: Point, _ direction: Direction) -> Bool {
    var point = point
    switch direction {
    case .n: point.x -= 1
    case .s: point.x += 1
    case .w: point.y += 1
    case .e: point.y -= 1
    }
    return walls[point.y][point.x]
}

@MainActor func isWallOnRight(_ point: Point, _ direction: Direction) -> Bool {
    var point = point
    switch direction {
    case .n: point.x += 1
    case .s: point.x -= 1
    case .w: point.y -= 1
    case .e: point.y += 1
    }
    return walls[point.y][point.x]
}

func addToStackIfNeeded(_ stack: inout [Path], bestPaths: inout [[BestPathsMulti]], path: Path) {
    switch path.direction {
    case .n:
        if let bestPath = bestPaths[path.position.y][path.position.x].n.first {
            if bestPath.score > path.score {
                bestPaths[path.position.y][path.position.x].n = [path]
                stack.append(path)
            } else if bestPath.score == path.score {
                bestPaths[path.position.y][path.position.x].n.append(path)
                stack.append(path)
            }
        } else {
            bestPaths[path.position.y][path.position.x].n = [path]
            stack.append(path)
        }
    case .e:
        if let bestPath = bestPaths[path.position.y][path.position.x].e.first {
            if bestPath.score > path.score {
                bestPaths[path.position.y][path.position.x].e = [path]
                stack.append(path)
            } else if bestPath.score == path.score {
                bestPaths[path.position.y][path.position.x].e.append(path)
                stack.append(path)
            }
        } else {
            bestPaths[path.position.y][path.position.x].e = [path]
            stack.append(path)
        }
    case .s:
        if let bestPath = bestPaths[path.position.y][path.position.x].s.first {
            if bestPath.score > path.score {
                bestPaths[path.position.y][path.position.x].s = [path]
                stack.append(path)
            } else if bestPath.score == path.score {
                bestPaths[path.position.y][path.position.x].s.append(path)
                stack.append(path)
            }
        } else {
            bestPaths[path.position.y][path.position.x].s = [path]
            stack.append(path)
        }
    case .w:
        if let bestPath = bestPaths[path.position.y][path.position.x].w.first {
            if bestPath.score > path.score {
                bestPaths[path.position.y][path.position.x].w = [path]
                stack.append(path)
            } else if bestPath.score == path.score {
                bestPaths[path.position.y][path.position.x].w.append(path)
                stack.append(path)
            }
        } else {
            bestPaths[path.position.y][path.position.x].w = [path]
            stack.append(path)
        }
    }
}

func visited(of paths: [Path]) -> Set<Point> {
    paths.reduce(into: Set<Point>()) { partialResult, path in
        partialResult.formUnion(visited(of: path))
    }
}

func visited(of path: Path) -> Set<Point> {
    var postions: Set<Point> = [path.start]
    var position = path.start
    var direction = path.startDirection
    for step in path.steps {
        switch step {
        case .forward:
            switch direction {
            case .n:
                position.y += -1
                postions.insert(position)
            case .e:
                position.x += 1
                postions.insert(position)
            case .s:
                position.y += 1
                postions.insert(position)
            case .w:
                position.x += -1
                postions.insert(position)
            }
        case .turnLeft:
            switch direction {
            case .e:
                direction = .n
                postions.insert(position)
            case .n:
                direction = .w
                postions.insert(position)
            case .w:
                direction = .s
                postions.insert(position)
            case .s:
                direction = .e
                postions.insert(position)
            }
        case .turnRight:
            switch direction {
            case .e:
                direction = .s
                postions.insert(position)
            case .n:
                direction = .e
                postions.insert(position)
            case .w:
                direction = .n
                postions.insert(position)
            case .s:
                direction = .w
                postions.insert(position)
            }
        }
    }
    return postions
}
