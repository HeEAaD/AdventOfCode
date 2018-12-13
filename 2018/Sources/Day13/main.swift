import Foundation

let fileURL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("input.txt")
let input = try String(contentsOf: fileURL).split(separator: "\n").map { Array($0) }

struct Cart {
    enum Direction {
        case up, right, down, left
    }

    enum TurnOption {
        case left, right, straight
    }

    var x: Int
    var y: Int
    var dir: Direction
    private var nextTurnOption = TurnOption.left

    init(x: Int, y: Int, dir: Direction) {
        self.x = x
        self.y = y
        self.dir = dir
    }

    mutating func move() {
        switch dir {
        case .up:
            y -= 1
        case .right:
            x += 1
        case .down:
            y += 1
        case .left:
            x -= 1
        }
    }

    mutating func rotate(char: Character) {
        switch char {
        case "/":
            switch dir {
            case .up:
                dir = .right
            case .right:
                dir = .up
            case .down:
                dir = .left
            case .left:
                dir = .down
            }
        case "\\":
            switch dir {
            case .up:
                dir = .left
            case .right:
                dir = .down
            case .down:
                dir = .right
            case .left:
                dir = .up
            }
        case "+":
            switch nextTurnOption {
            case .left:
                nextTurnOption = .straight
                switch dir {
                case .up:
                    dir = .left
                case .right:
                    dir = .up
                case .down:
                    dir = .right
                case .left:
                    dir = .down
                }
            case .right:
                nextTurnOption = .left
                switch dir {
                case .up:
                    dir = .right
                case .right:
                    dir = .down
                case .down:
                    dir = .left
                case .left:
                    dir = .up
                }
            case .straight:
                nextTurnOption = .right
            }
        default: break
        }
    }
}

var carts = [Cart]()
for (y, row) in input.enumerated() {
    for (x, char) in row.enumerated() {
        switch char {
        case "<":
            carts.append(Cart(x: x, y: y, dir: .left))
        case ">":
            carts.append(Cart(x: x, y: y, dir: .right))
        case "^":
            carts.append(Cart(x: x, y: y, dir: .up))
        case "v":
            carts.append(Cart(x: x, y: y, dir: .down))
        default: continue
        }
    }
}

let tracks = input.map { row in
    row.map { char -> Character in
        switch char {
        case "<", ">": return "-"
        case "^", "v": return "|"
        default: return char
        }
    }
}

func print(tracks: [[Character]], carts: [Cart]) {
    var grid = tracks
    for cart in carts {
        switch cart.dir {
        case .up:
            grid[cart.y][cart.x] = "^"
        case .right:
            grid[cart.y][cart.x] = ">"
        case .down:
            grid[cart.y][cart.x] = "v"
        case .left:
            grid[cart.y][cart.x] = "<"
        }
    }

    for row in grid {
        print(String(row))
    }
    print()
}

func findFirstCrash(tracks: [[Character]], carts: [Cart]) -> (x: Int, y: Int) {
    var carts = carts
    while true {
        carts.sort { lhs, rhs in
            if lhs.y == rhs.y {
                return lhs.x < rhs.y
            }
            return lhs.y < rhs.y
        }

        for i in 0..<carts.count {
            carts[i].move()
            carts[i].rotate(char: tracks[carts[i].y][carts[i].x])

            for j in 0..<carts.count where i != j {
                if carts[i].x == carts[j].x && carts[i].y == carts[j].y {
                    return (carts[i].x, carts[i].y)
                }
            }
        }
    }

    preconditionFailure()
}

let firstCrashLocation = findFirstCrash(tracks: tracks, carts: carts)
print("Task 1: \(firstCrashLocation.x),\(firstCrashLocation.y)") // 111,13

func lastCarLocation(tracks: [[Character]], carts: [Cart]) -> (x: Int, y: Int) {
    var carts = carts

    while carts.count != 1 {
        carts.sort { lhs, rhs in
            if lhs.y == rhs.y {
                return lhs.x > rhs.x
            }
            return lhs.y > rhs.y
        }

        var movedCarts = [Cart]()

        while !carts.isEmpty {
            var cart = carts.removeLast()
            cart.move()
            cart.rotate(char: tracks[cart.y][cart.x])

            let sameLocationAsCart: (Cart) -> Bool = { $0.x == cart.x && $0.y == cart.y }

            var crashed = false

            // check crash with already moved carts
            if movedCarts.contains(where: sameLocationAsCart) {
                movedCarts.removeAll(where: sameLocationAsCart)
                crashed = true
            }

            // check crash with non moved carts
            if carts.contains(where: sameLocationAsCart) {
                carts.removeAll(where: sameLocationAsCart)
                crashed = true
            }

            if !crashed {
                movedCarts.append(cart)
            }
        }

        carts = movedCarts
    }

    return (carts[0].x, carts[0].y)
}

let task2 = lastCarLocation(tracks: tracks, carts: carts)
print("Task 2: \(task2.x),\(task2.y)") // 16,73
