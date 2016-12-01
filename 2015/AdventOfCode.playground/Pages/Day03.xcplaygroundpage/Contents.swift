import Foundation

let path = NSBundle.mainBundle().pathForResource("day03_input", ofType: "txt")
let input = try String(contentsOfFile: path!)

struct Coordinate {
    var x:Int
    var y:Int
}

extension Coordinate {
    mutating func step(direction:Character) {
        switch direction {
        case ">": x++
        case "<": x--
        case "^": y++
        case "v": y--
        default: return
        }
    }
}

extension Coordinate : Hashable {
    var hashValue: Int {
        return "\(x)x\(y)".hashValue
    }
}

func ==(lhs: Coordinate, rhs: Coordinate) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}

let seed = Coordinate(x: 0, y: 0)
let santas = 2 // 1 for Task 1, 2 for Task 2
var visitedHouses = Set([seed])
var lastVisitedHouses = Array(count: santas, repeatedValue: seed)
for (i,c) in input.characters.enumerate() {
    var h = lastVisitedHouses[i % santas]
    h.step(c)
    lastVisitedHouses[i % santas] = h
    visitedHouses.insert(h)
}
visitedHouses.count
