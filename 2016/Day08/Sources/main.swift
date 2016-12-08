import Foundation

let path = #file.components(separatedBy: "/Sources/main.swift").first! + "/Input/Input.txt"
let input = try String(contentsOfFile: path)
    .components(separatedBy: .newlines)
    .filter { $0 != "" }

class Grid {

    var grid: [[Bool]]

    init(columns: Int, rows: Int) {
        self.grid = Array(repeating: Array(repeating: false, count: columns), count: rows)
    }

    func rect(a: Int, b: Int) {
        for row in 0..<b {
            for column in 0..<a {
                grid[row][column] = true
            }
        }
    }

    func column(_ column: Int) -> [Bool] {
        var result = [Bool]()
        for row in 0..<grid.count {
            result.append(grid[row][column])
        }
        return result
    }

    func rotate(column: Int, by offset: Int ) {
        let shiftedColumn = self.column(column).shifted(by: offset)
        for row in 0..<grid.count {
            grid[row][column] = shiftedColumn[row]
        }
    }

    func rotate(row: Int, by offset: Int ) {
        self.grid[row] = self.grid[row].shifted(by: offset)
    }

    var lit: Int {
        var result = 0
        for row in 0..<self.grid.count {
            result += grid[row].reduce(0) { $0 + ($1 ? 1 : 0) }
        }
        return result
    }
}

extension Grid: CustomStringConvertible {
    public var description: String {
        var rows = ""
        for y in grid {
            rows.append(y.map { $0 ? "#" : "." }.joined())
            rows.append("\n")
        }
        return rows
    }
}

extension Array {

    func shifted(by offset: Int) -> [Element] {
        var result = self
        for i in 0..<self.count {
            result[i] = self[(i - offset + self.count) % self.count]
        }
        return result
    }
}

//let grid = Grid(columns: 7, rows: 3)
//print(grid)
//grid.rect(a: 3, b: 2)
//print(grid)
//grid.rotate(column: 1, by: 1)
//print(grid)
//grid.rotate(row: 0, by: 4)
//print(grid)
//grid.rotate(column: 1, by: 1)
//print(grid)

let grid = Grid(columns: 50, rows: 6)

for line in input {
    let components = line.components(separatedBy: " ")
    switch components[0] {
    case "rect":
        let components = components[1].components(separatedBy: "x")
        grid.rect(a: Int(components[0])!, b: Int(components[1])!)
    case "rotate":
        let i = Int(components[2].components(separatedBy: "=").last!)!
        switch components[1] {
        case "column":
            grid.rotate(column: i, by: Int(components[4])!)
        case "row":
            grid.rotate(row: i, by: Int(components[4])!)
        default:
            assertionFailure()
        }
    default:
        assertionFailure()
    }
}

print("Task 1: \(grid.lit)") // 121
print("Task 2:\n\(grid)") // RURUCEOEIL
