import Foundation

let input = "L5, R1, R4, L5, L4, R3, R1, L1, R4, R5, L1, L3, R4, L2, L4, R2, L4, L1, R3, R1, R1, L1, R1, L5, R5, R2, L5, R2, R1, L2, L4, L4, R191, R2, R5, R1, L1, L2, R5, L2, L3, R4, L1, L1, R1, R50, L1, R1, R76, R5, R4, R2, L5, L3, L5, R2, R1, L1, R2, L3, R4, R2, L1, L1, R4, L1, L1, R185, R1, L5, L4, L5, L3, R2, R3, R1, L5, R1, L3, L2, L2, R5, L1, L1, L3, R1, R4, L2, L1, L1, L3, L4, R5, L2, R3, R5, R1, L4, R5, L3, R3, R3, R1, R1, R5, R2, L2, R5, L5, L4, R4, R3, R5, R1, L3, R1, L2, L2, R3, R4, L1, R4, L1, R4, R3, L1, L4, L1, L5, L2, R2, L1, R1, L5, L3, R4, L1, R5, L5, L5, L1, L3, R1, R5, L2, L4, L5, L1, L1, L2, R5, R5, L4, R3, L2, L1, L3, L4, L5, L5, L2, R4, R3, L5, R4, R2, R1, L5"


struct Position {
    var x: Int
    var y: Int
    var heading: UInt // 0, 90, 180, 270
    
    mutating func rotate(direction: String) {
        if direction.hasPrefix("R") {
            heading = (heading + 90) % 360
        } else if direction.hasPrefix("L") {
            heading = (heading + 270) % 360
        }
    }
    
    mutating func move(_ steps: Int = 1) {
        switch heading {
        case 0:
            y += steps
        case 90:
            x += steps
        case 180:
            y -= steps
        case 270:
            x -= steps
        default:
            assertionFailure()
        }
    }
}

extension String {
    var steps: Int {
        let index = self.index(self.startIndex, offsetBy: 1)
        return Int(self.substring(from: index)) ?? 0
    }
}

let directions = input.components(separatedBy: ", ")
let startPosition = Position(x: 0, y: 0, heading: 0)

// Task 1
let finalPosition = directions.reduce(startPosition) { position, direction in
    var newPosition = position
    newPosition.rotate(direction: direction)
    newPosition.move(direction.steps)
    return newPosition
}

let task1 = abs(finalPosition.x - startPosition.x) + abs(finalPosition.y - startPosition.y)
print("Task 1: \(task1)") // 242

// Task 2
var visitied = [(x: Int, y: Int)]()
visitied.append((x: startPosition.x, y: startPosition.y))
var currentPostion = startPosition
for direction in directions {
    currentPostion.rotate(direction: direction)
    for _ in 0..<direction.steps {
        currentPostion.move()
        let found = visitied.contains() { x, y in
            return currentPostion.x == x && currentPostion.y == y
        }
        
        if found {
            let task2 = abs(currentPostion.x - startPosition.x) + abs(currentPostion.y - startPosition.y)
            print("Task 2: \(task2)") // 150
            exit(0)
        } else {
            visitied.append((x: currentPostion.x, y: currentPostion.y))
        }
    }
}
