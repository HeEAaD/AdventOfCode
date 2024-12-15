let map: [[Tile]] = inputMap
    .split(whereSeparator: \.isNewline)
    .reduce(into: []) { partialResult, line in
        partialResult.append(line.map { Tile(rawValue: $0)! })
    }

let moves: [Move] = inputMoves.compactMap { char -> Move? in
    char.isNewline ? nil : Move(rawValue: char)!
}

print("Answer 1:", task1(map))
print("Answer 2:", task2(map))

// MARK: - Methods

enum Tile: Character {
    case wall = "#"
    case open = "."
    case robot = "@"
    case box = "O"
}

enum Tile2: Character {
    case wall = "#"
    case open = "."
    case robot = "@"
    case boxL = "["
    case boxR = "]"
}

enum Move: Character {
    case up = "^"
    case down = "v"
    case left = "<"
    case right = ">"
}

struct Point: Hashable {
    var x: Int
    var y: Int
}

func task1(_ map: [[Tile]]) -> Int {
    var map = map
    var robotPosition: Point!
    for y in map.indices {
        for x in map[y].indices {
            if map[y][x] == .robot {
                robotPosition = Point(x: x, y: y)
                break
            }
        }
    }

    for i in moves.indices {
        move(&robotPosition, moves[i], in: &map)
    }

    var sum = 0
    for y in map.indices {
        for x in map[y].indices {
            if map[y][x] == .box {
                sum += 100 * y + x
            }
        }
    }

    return sum
}

func task2(_ map: [[Tile]]) -> Int {
    var map2: [[Tile2]] = []

    for y in map.indices {
        var row: [Tile2] = []
        for x in map[y].indices {
            switch map[y][x] {
            case .open:
                row.append(.open)
                row.append(.open)
            case .box:
                row.append(.boxL)
                row.append(.boxR)
            case .robot:
                row.append(.robot)
                row.append(.open)
            case .wall:
                row.append(.wall)
                row.append(.wall)
            }
        }
        map2.append(row)
    }

    var robotPosition: Point!
    for y in map2.indices {
        for x in map2[y].indices {
            if map2[y][x] == .robot {
                robotPosition = Point(x: x, y: y)
            }
        }
    }

    for i in moves.indices {
        move2(&robotPosition, moves[i], in: &map2)
    }

    var sum = 0
    for y in map2.indices {
        for x in map2[y].indices {
            if map2[y][x] == .boxL {
                sum += 100 * y + x
            }
        }
    }

    return sum
}

func move(_ robotPosition: inout Point, _ move: Move, in map: inout [[Tile]]) {
    switch move {
    case .up:
        moveUp(&robotPosition, in: &map)
    case .down:
        moveDown(&robotPosition, in: &map)
    case .left:
        moveLeft(&robotPosition, in: &map)
    case .right:
        moveRight(&robotPosition, in: &map)
    }
}

func moveUp(_ robotPosition: inout Point, in map: inout [[Tile]]) {
    switch map[robotPosition.y - 1][robotPosition.x] {
    case .robot:
        fatalError()
    case .wall:
        return
    case .open:
        map[robotPosition.y][robotPosition.x] = .open
        map[robotPosition.y - 1][robotPosition.x] = .robot
        robotPosition.y -= 1
    case .box:
        for y in (1..<robotPosition.y).reversed() {
            switch map[y][robotPosition.x] {
            case .robot:
                fatalError()
            case .wall:
                return
            case .box:
                break
            case .open:
                for yBox in y...robotPosition.y - 1 {
                    map[yBox][robotPosition.x] = .box
                }
                map[robotPosition.y][robotPosition.x] = .open
                map[robotPosition.y - 1][robotPosition.x] = .robot
                robotPosition.y -= 1
                return
            }
        }
    }
}

func moveRight(_ robotPosition: inout Point, in map: inout [[Tile]]) {
    switch map[robotPosition.y][robotPosition.x + 1] {
    case .robot:
        fatalError()
    case .wall:
        return
    case .open:
        map[robotPosition.y][robotPosition.x] = .open
        map[robotPosition.y][robotPosition.x + 1] = .robot
        robotPosition.x += 1
    case .box:
        for x in robotPosition.x+1..<map[robotPosition.y].count {
            switch map[robotPosition.y][x] {
            case .robot:
                fatalError()
            case .wall:
                return
            case .box:
                break
            case .open:
                for xBox in robotPosition.x + 1...x {
                    map[robotPosition.y][xBox] = .box
                }
                map[robotPosition.y][robotPosition.x] = .open
                map[robotPosition.y][robotPosition.x + 1] = .robot
                robotPosition.x += 1
                return
            }
        }
    }
}

func moveLeft(_ robotPosition: inout Point, in map: inout [[Tile]]) {
    switch map[robotPosition.y][robotPosition.x - 1] {
    case .robot:
        fatalError()
    case .wall:
        return
    case .open:
        map[robotPosition.y][robotPosition.x] = .open
        map[robotPosition.y][robotPosition.x - 1] = .robot
        robotPosition.x -= 1
    case .box:
        for x in (1...robotPosition.x-1).reversed() {
            switch map[robotPosition.y][x] {
            case .robot:
                fatalError()
            case .wall:
                return
            case .box:
                break
            case .open:
                for xBox in x...robotPosition.x - 1 {
                    map[robotPosition.y][xBox] = .box
                }
                map[robotPosition.y][robotPosition.x] = .open
                map[robotPosition.y][robotPosition.x - 1] = .robot
                robotPosition.x -= 1
                return
            }
        }
    }
}

func moveDown(_ robotPosition: inout Point, in map: inout [[Tile]]) {
    switch map[robotPosition.y + 1][robotPosition.x] {
    case .robot:
        fatalError()
    case .wall:
        return
    case .open:
        map[robotPosition.y][robotPosition.x] = .open
        map[robotPosition.y + 1][robotPosition.x] = .robot
        robotPosition.y += 1
    case .box:
        for y in robotPosition.y+1..<map.count {
            switch map[y][robotPosition.x] {
            case .robot:
                fatalError()
            case .wall:
                return
            case .box:
                break
            case .open:
                for yBox in robotPosition.y + 1...y {
                    map[yBox][robotPosition.x] = .box
                }
                map[robotPosition.y][robotPosition.x] = .open
                map[robotPosition.y + 1][robotPosition.x] = .robot
                robotPosition.y += 1
                return
            }
        }
    }
}

func move2(_ robotPosition: inout Point, _ move: Move, in map: inout [[Tile2]]) {
    switch move {
    case .up:
        moveUp2(&robotPosition, in: &map)
    case .down:
        moveDown2(&robotPosition, in: &map)
    case .left:
        moveLeft2(&robotPosition, in: &map)
    case .right:
        moveRight2(&robotPosition, in: &map)
    }
}

func moveUp2(_ robotPosition: inout Point, in map: inout [[Tile2]]) {
    switch map[robotPosition.y - 1][robotPosition.x] {
    case .robot:
        fatalError()
    case .wall:
        return
    case .open:
        map[robotPosition.y][robotPosition.x] = .open
        map[robotPosition.y - 1][robotPosition.x] = .robot
        robotPosition.y -= 1
    case .boxL, .boxR:
        var boxes: Set<Point> = []
        var stack: [Point] = [Point(x: robotPosition.x, y: robotPosition.y - 1)]
        var canMove = true
        while let point = stack.popLast() {
            let x = point.x
            let y = point.y

            if map[y - 1][x] == .wall {
                canMove = false
                break
            } else if map[y - 1][x] == .boxL || map[y - 1][x] == .boxR {
                stack.append(Point(x: x, y: y - 1))
            }

            boxes.insert(point)

            if map[y][x] == .boxL {
                let boxR = Point(x: x + 1, y: y)
                if !boxes.contains(boxR) {
                    stack.append(boxR)
                }
            } else if map[y][x] == .boxR {
                let boxL = Point(x: x - 1, y: y)
                if !boxes.contains(boxL) {
                    stack.append(boxL)
                }
            } else {
                fatalError()
            }
        }

        guard canMove else { return }

        for point in boxes.sorted(by: { $0.y < $1.y }) {
            map[point.y - 1][point.x] = map[point.y][point.x]
            map[point.y][point.x] = .open
        }
        map[robotPosition.y][robotPosition.x] = .open
        map[robotPosition.y - 1][robotPosition.x] = .robot
        robotPosition.y -= 1
    }
}

func moveRight2(_ robotPosition: inout Point, in map: inout [[Tile2]]) {
    switch map[robotPosition.y][robotPosition.x + 1] {
    case .robot:
        fatalError()
    case .wall:
        return
    case .open:
        map[robotPosition.y][robotPosition.x] = .open
        map[robotPosition.y][robotPosition.x + 1] = .robot
        robotPosition.x += 1
    case .boxL, .boxR:
        for x in robotPosition.x+1..<map[robotPosition.y].count {
            switch map[robotPosition.y][x] {
            case .robot:
                fatalError()
            case .wall:
                return
            case .boxL, .boxR:
                break
            case .open:
                for xBox in (robotPosition.x + 1...x).reversed() {
                    map[robotPosition.y][xBox] = map[robotPosition.y][xBox - 1]
                }
                map[robotPosition.y][robotPosition.x] = .open
                map[robotPosition.y][robotPosition.x + 1] = .robot
                robotPosition.x += 1
                return
            }
        }
    }
}

func moveLeft2(_ robotPosition: inout Point, in map: inout [[Tile2]]) {
    switch map[robotPosition.y][robotPosition.x - 1] {
    case .robot:
        fatalError()
    case .wall:
        return
    case .open:
        map[robotPosition.y][robotPosition.x] = .open
        map[robotPosition.y][robotPosition.x - 1] = .robot
        robotPosition.x -= 1
    case .boxL, .boxR:
        for x in (1...robotPosition.x-1).reversed() {
            switch map[robotPosition.y][x] {
            case .robot:
                fatalError()
            case .wall:
                return
            case .boxL, .boxR:
                break
            case .open:
                for xBox in x...robotPosition.x - 1 {
                    map[robotPosition.y][xBox] = map[robotPosition.y][xBox + 1]
                }
                map[robotPosition.y][robotPosition.x] = .open
                map[robotPosition.y][robotPosition.x - 1] = .robot
                robotPosition.x -= 1
                return
            }
        }
    }
}

func moveDown2(_ robotPosition: inout Point, in map: inout [[Tile2]]) {
    switch map[robotPosition.y + 1][robotPosition.x] {
    case .robot:
        fatalError()
    case .wall:
        return
    case .open:
        map[robotPosition.y][robotPosition.x] = .open
        map[robotPosition.y + 1][robotPosition.x] = .robot
        robotPosition.y += 1
    case .boxL, .boxR:
        var boxes: Set<Point> = []
        var stack: [Point] = [Point(x: robotPosition.x, y: robotPosition.y + 1)]
        var canMove = true
        while let point = stack.popLast() {
            let x = point.x
            let y = point.y

            if map[y + 1][x] == .wall {
                canMove = false
                break
            } else if map[y + 1][x] == .boxL || map[y + 1][x] == .boxR {
                stack.append(Point(x: x, y: y + 1))
            }

            boxes.insert(point)

            if map[y][x] == .boxL {
                let boxR = Point(x: x + 1, y: y)
                if !boxes.contains(boxR) {
                    stack.append(boxR)
                }
            } else if map[y][x] == .boxR {
                let boxL = Point(x: x - 1, y: y)
                if !boxes.contains(boxL) {
                    stack.append(boxL)
                }
            } else {
                fatalError()
            }
        }

        guard canMove else { return }

        for point in boxes.sorted(by: { $0.y > $1.y }) {
            map[point.y + 1][point.x] = map[point.y][point.x]
            map[point.y][point.x] = .open
        }
        map[robotPosition.y][robotPosition.x] = .open
        map[robotPosition.y + 1][robotPosition.x] = .robot
        robotPosition.y += 1
    }
}
