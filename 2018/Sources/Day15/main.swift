class Unit {
    enum OpponentType {
        case goblin, elf
    }

    let type: OpponentType
    var hp = 200
    var x: Int
    var y: Int
    var ap = 3

    init(type: OpponentType, x: Int, y: Int) {
        self.type = type
        self.x = x
        self.y = y
    }

    convenience init(unit: Unit) {
        self.init(type: unit.type, x: unit.x, y: unit.y)
    }
}

class Battle: CustomDebugStringConvertible {
    let area: [[Bool]]
    var elfs: [Unit]
    var goblins: [Unit]

    init(area: [[Bool]], elfs: [Unit], goblins: [Unit]) {
        self.area = area
        self.elfs = elfs
        self.goblins = goblins
    }

    func isEmpty(_ location: (x: Int, y: Int)) -> Bool {
        return !area[location.y][location.x] &&
            !elfs.contains(where: { $0.x == location.x && $0.y == location.y }) &&
            !goblins.contains(where: { $0.x == location.x && $0.y == location.y })
    }

    func shortestPath(from: (x: Int, y: Int), to: (x: Int, y: Int)) -> [(x: Int, y: Int)]? {
        var visited = [from]
        var paths = [[from]]
        while true {
            var newPaths = [[(x: Int, y: Int)]]()
            for path in paths {
                var nextPoss: [(x: Int, y: Int)] = [
                    (path.last!.x, path.last!.y - 1),
                    (path.last!.x - 1, path.last!.y),
                    (path.last!.x + 1, path.last!.y),
                    (path.last!.x, path.last!.y + 1),
                ]
                nextPoss = nextPoss.filter { pos in
                    return isEmpty(pos) &&
                        !visited.contains(where: { $0.x == pos.x && $0.y == pos.y })
                }

                for nextPos in nextPoss {
                    visited.append(nextPos)
                    newPaths.append(path + [nextPos])
                }
            }

            paths = newPaths

            let foundPaths = paths.filter { $0.last?.x == to.x && $0.last?.y == to.y }
            if !foundPaths.isEmpty {
                return foundPaths.sorted { lhs, rhs in
                    if lhs.count == rhs.count {
                        if lhs[1].y == rhs[1].y {
                            return lhs[1].x < rhs[1].x
                        }
                        return lhs[1].y < rhs[1].y
                    }
                    return lhs.count < rhs.count
                }.first!
            }

            // not reachable
            if paths.isEmpty {
                return nil
            }
        }
    }

    func move(unit: Unit) {
        let others = unit.type == .elf ? goblins : elfs

        let inRange: [(x: Int, y: Int)] = others.reduce([]) { result, opponent in
            return result + [
                (opponent.x - 1, opponent.y),
                (opponent.x, opponent.y + 1),
                (opponent.x, opponent.y - 1),
                (opponent.x + 1, opponent.y),
            ].filter { pos in
                isEmpty(pos)
            }
        }

        let paths = inRange
            .compactMap { toLocation -> [(x: Int, y: Int)]? in
                return shortestPath(from: (unit.x, unit.y), to: toLocation)
            }
            .sorted { lhs, rhs in
                if lhs.count == rhs.count {
                    if lhs[1].y == rhs[1].y {
                        return lhs[1].x < rhs[1].x
                    }
                    return lhs[1].y < rhs[1].y
                }
                return lhs.count < rhs.count
            }

        guard let loc = paths.first?[1] else {
            return
        }
        unit.x = loc.x
        unit.y = loc.y
    }

    func unitToAttack(unit: Unit) -> Unit? {
        let others = unit.type == .elf ? goblins : elfs
        let adjacentUnits = others
            .filter { otherUnit in
                return abs(otherUnit.x - unit.x) + abs(otherUnit.y - unit.y) == 1
            }
            .sorted { lhs, rhs in
                if lhs.hp == rhs.hp {
                    if lhs.y == rhs.y {
                        return lhs.x < rhs.x
                    }
                    return lhs.y < rhs.y
                }
                return lhs.hp < rhs.hp
            }

        return adjacentUnits.first
    }

    /// Returns: (is over, at end of round)
    func aRound() -> (Bool, Bool) {
        var toMoves = (goblins + elfs)
        while !toMoves.isEmpty {
            toMoves.sort(by: { lhs, rhs in
                if lhs.y == rhs.y {
                    return lhs.x > rhs.x
                }
                return lhs.y > rhs.y
            })
            let unit = toMoves.removeLast()
            if let otherUnit = unitToAttack(unit: unit) {
                otherUnit.hp -= unit.ap
                goblins = goblins.filter { $0.hp > 0 }
                elfs = elfs.filter { $0.hp > 0 }
                toMoves = toMoves.filter { $0.hp > 0 }

                switch unit.type {
                case .elf:
                    if goblins.isEmpty {
                        return (true, toMoves.isEmpty)
                    }
                case .goblin:
                    if elfs.isEmpty {
                        return (true, toMoves.isEmpty)
                    }
                }

                continue
            }

            move(unit: unit)

            unitToAttack(unit: unit)?.hp -= unit.ap
            goblins = goblins.filter { $0.hp > 0 }
            elfs = elfs.filter { $0.hp > 0 }
            toMoves = toMoves.filter { $0.hp > 0 }
            switch unit.type {
            case .elf:
                if goblins.isEmpty {
                    return (true, toMoves.isEmpty)
                }
            case .goblin:
                if elfs.isEmpty {
                    return (true, toMoves.isEmpty)
                }
            }
        }

        return (false, true)
    }

    func outcome() -> (elfs: [Unit], goblins: [Unit], fullRounds: Int) {
//        print(debugDescription)

        for round in 1...Int.max {
            let (isOver, atEndOfRound) = aRound()
            if isOver {
                let fullRounds = atEndOfRound ? round : round - 1
                print("Outcome:")
                print(debugDescription)
                return (elfs, goblins, fullRounds)
            }
//            print("After \(round) round:")
//            print(debugDescription)
        }
        fatalError()
    }

    var debugDescription: String {
        var debugDescription = ""
        for (y, row) in area.enumerated() {
            var debugLine = ""
            for (x, isWall) in row.enumerated() {
                if isWall {
                    debugDescription += "#"
                } else if let elf = elfs.first(where: { $0.x == x && $0.y == y }) {
                    if !debugLine.isEmpty { debugLine += ", " }
                    debugLine += "E(\(elf.hp))"
                    debugDescription += "E"
                } else if let goblin = goblins.first(where: { $0.x == x && $0.y == y }) {
                    if !debugLine.isEmpty { debugLine += ", " }
                    debugLine += "G(\(goblin.hp))"
                    debugDescription += "G"
                } else {
                    debugDescription += "."
                }
            }
            debugDescription += "   \(debugLine)\n"
        }

        return debugDescription
    }
}

func parse(input: String) -> (area: [[Bool]], elfs: [Unit], goblins: [Unit]) {
    let width = input.split(separator: "\n")[0].count
    let height = input.split(separator: "\n").count
    // true == wall
    var area = Array(repeating: Array(repeating: true, count: width), count: height)
    var elfs = [Unit]()
    var goblins = [Unit]()
    for (y, row) in input.split(separator: "\n").enumerated() {
        for (x, char) in row.enumerated() {
            switch char {
            case "#":
                area[y][x] = true
            case ".":
                area[y][x] = false
            case "G":
                area[y][x] = false
                goblins.append(Unit(type: .goblin, x: x, y: y))
            case "E":
                area[y][x] = false
                elfs.append(Unit(type: .elf, x: x, y: y))
            default: fatalError()
            }
        }
    }
    return (area, elfs, goblins)
}

let parsedInput = parse(input: input)
let battle = Battle(area: parsedInput.area,
                    elfs: parsedInput.elfs.map(Unit.init),
                    goblins: parsedInput.goblins.map(Unit.init))
let (elfs, goblins, fullRounds) = battle.outcome()
let hpSum = (elfs + goblins).reduce(0) { $0 + $1.hp }
print("Task 1: \(hpSum * fullRounds)")

for ap in 4..<Int.max {
    let powerfulElfs = parsedInput.elfs.map { elf -> Unit in
        let powerfulElf = Unit(unit: elf)
        powerfulElf.ap = ap
        return powerfulElf
    }
    let battle = Battle(area: parsedInput.area,
                        elfs: powerfulElfs,
                        goblins: parsedInput.goblins.map(Unit.init))
    let (elfsAfterBattle, _, fullRounds) = battle.outcome()
    if powerfulElfs.count == elfsAfterBattle.count {
        let hpSum = elfsAfterBattle.reduce(0) { $0 + $1.hp }
        print("Task 2: \(hpSum * fullRounds)")
        break
    }
}
