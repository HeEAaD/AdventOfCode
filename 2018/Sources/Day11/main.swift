import Dispatch

let serialNumber = 7857
var grid = Array(repeating: Array(repeating: 0, count: 300), count: 300)

func powerLevel(coordX: Int, coordY: Int, serialNumber: Int) -> Int {
    let rackID = coordX + 10
    var powerLevel = rackID * coordY
    powerLevel += serialNumber
    powerLevel *= rackID
    powerLevel = (powerLevel / 100) % 10
    powerLevel -= 5
    return powerLevel
}

assert(powerLevel(coordX: 3, coordY: 5, serialNumber: 8) == 4)
assert(powerLevel(coordX: 122, coordY: 79, serialNumber: 57) == -5)
assert(powerLevel(coordX: 217, coordY: 196, serialNumber: 39) == 0)
assert(powerLevel(coordX: 101, coordY: 153, serialNumber: 71) == 4)

for y in 0..<grid.count {
    for x in 0..<grid[y].count {
        grid[y][x] = powerLevel(coordX: x + 1,
                                coordY: y + 1,
                                serialNumber: serialNumber)
    }
}

func maxPower(grid: [[Int]], squareSize: Int) -> (Int, Int, Int) {
    var result = (0, 0, Int.min)
    for y in 0..<grid.count - squareSize - 1 {
        for x in 0..<grid[y].count - squareSize - 1 {
            var power = 0
            for j in y..<y + squareSize {
                for i in x..<x + squareSize {
                    power += grid[j][i]
                }
            }
            if power > result.2 {
                result = (x + 1, y + 1, power)
            }
        }
    }
    return result
}

let maxPower3Square = maxPower(grid: grid, squareSize: 3)
print("Task 1: \(maxPower3Square.0),\(maxPower3Square.1)")

// squaresize: maxPower results
var maxPowers = [Int: (Int, Int, Int)]()

DispatchQueue.concurrentPerform(iterations: 299) { iteration in
    let squareSize = iteration + 1
    maxPowers[squareSize] = maxPower(grid: grid, squareSize: squareSize)
}

let totalMax = maxPowers.max { $0.value.2 < $1.value.2 }!
print("Task 2: \(totalMax.value.0),\(totalMax.value.0),\(totalMax.key)")
