struct Coord: Hashable {
    let x: Int
    let y: Int
}

func isSymbol(_ character: Character) -> Bool {
    character != "."
}

func adjacentSymbols(x: Int, y: Int, length: Int) -> [(char: Character, coord: Coord)] {
    var result: [(Character, Coord)] = []
    if x > 0, isSymbol(grid[y][x-1]) {
        result.append((grid[y][x-1], Coord(x: x-1, y: y)))
    }
    if x + length < grid[y].count, isSymbol(grid[y][x+length]) {
        result.append((grid[y][x+length], Coord(x: x+length, y: y)))
    }
    if y > 0 {
        for x2 in max(0, x-1)...min(grid[y-1].count - 1, x+length) where isSymbol(grid[y-1][x2]) {
            result.append((grid[y-1][x2], Coord(x: x2, y: y-1)))
        }
    }
    if y + 1 < grid.count {
        for x2 in max(0, x-1)...min(grid[y+1].count - 1, x+length) where isSymbol(grid[y+1][x2]) {
            result.append((grid[y+1][x2], Coord(x: x2, y: y+1)))
        }
    }
    return result
}

let grid = input.split(whereSeparator: \.isNewline).map(Array.init)

var gearToNumbers: [Coord: [Int]] = [:]
var partNumberSum = 0

for y in 0..<grid.count {
    var numberString = ""
    var numberStartX: Int?
    for x in 0...grid[y].count {
        if x < grid[y].count && grid[y][x].isNumber {
            if numberString.isEmpty {
                numberString = String(grid[y][x])
                numberStartX = x
            } else {
                numberString += String(grid[y][x])
            }
        } else if !numberString.isEmpty {
            let adjutantSymbols = adjacentSymbols(x: numberStartX!, y: y, length: numberString.count)
            if !adjutantSymbols.isEmpty {
                let number = Int(numberString)!
                partNumberSum += number
                for adjutantSymbol in adjutantSymbols where adjutantSymbol.char == "*" {
                    gearToNumbers[adjutantSymbol.coord, default: []].append(number)
                }
            }
            numberString = ""
            numberStartX = nil
        }
    }
}

print("Answer 1:", partNumberSum)

let gearRatioSum = gearToNumbers.reduce(into: 0) { result, gearToNumber in
    if gearToNumber.value.count > 1 {
        result += gearToNumber.value.reduce(into: 1, *=)
    }
}
print("Answer 2:", gearRatioSum)
