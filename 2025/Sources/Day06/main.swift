enum Operation: String {
    case add = "+"
    case multiply = "*"
}

enum Cell: Equatable {
    case space
    case digit(Character)
    case operation(Operation)

    init(_ char: Character) {
        if char == " " {
            self = .space
        } else if let operation = Operation(rawValue: String(char)) {
            self = .operation(operation)
        } else {
            self = .digit(char)
        }
    }
}

typealias IntType = Int64

let lines = input.split(whereSeparator: \.isNewline)
let sheet = lines.map { $0.split(whereSeparator: \.isWhitespace) }
var grantTotal: IntType = 0

for column in sheet[0].indices {
    let operation = Operation(rawValue: String(sheet[sheet.count - 1][column]))!
    var total = IntType(sheet[0][column])!
    for row in 1..<(sheet.count - 1) {
        let value = IntType(sheet[row][column])!
        switch operation {
        case .add:
            total += value
        case .multiply:
            total *= value
        }
    }
    grantTotal += total
}

print("Answer 1:", grantTotal)

let rawSheet = lines.map { $0.map(Cell.init) }
var rightBoundary = rawSheet[0].count
grantTotal = 0

for (i, cell) in rawSheet.last!.enumerated().reversed() {
    guard case let .operation(operation) = cell else { continue }

    var total: IntType
    switch operation {
    case .add:
        total = 0
    case .multiply:
        total = 1
    }

    for j in (i..<rightBoundary).reversed() {
        let columnString = rawSheet
            .dropLast()
            .map { row -> String in
                switch row[j] {
                case .space:
                    return ""
                case let .digit(char):
                    return String(char)
                case .operation:
                    fatalError("Unexpected operation cell")
                }
            }
            .joined()

        let columnValue = IntType(columnString)!

        switch operation {
        case .add:
            total += columnValue
        case .multiply:
            total *= columnValue
        }
    }
    grantTotal += total
    rightBoundary = i - 1
}

print("Answer 2:", grantTotal)
