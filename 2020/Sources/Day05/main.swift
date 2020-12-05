func seatID(pass: String) -> Int {
    var rowLow = 0
    var rowUp = 127
    var columnLow = 0
    var columnUp = 7
    for (index, char) in pass.enumerated() {
        if index < 7 {
            if char == "B" {
                rowLow = (rowLow + rowUp + 1) / 2
            } else if char == "F" {
                rowUp = (rowLow + rowUp + 1) / 2 - 1
            } else {
                assertionFailure()
            }
        } else {
            if char == "R" {
                columnLow = (columnLow + columnUp + 1) / 2
            } else if char == "L" {
                columnUp = (columnLow + columnUp + 1) / 2 - 1
            } else {
                assertionFailure()
            }
        }
    }
    assert(rowUp == rowLow)
    assert(columnUp == columnLow)
    return rowLow * 8 + columnLow
}

let seatIDs = input.split(whereSeparator: \.isNewline)
    .map { seatID(pass: String($0)) }
    .sorted()

print("Answer 1: \(seatIDs.last!)")

var lastSeatID = 0
for seatID in seatIDs {
    if seatID - lastSeatID == 2 {
        break
    }
    lastSeatID = seatID
}

print("Answer 2: \(lastSeatID + 1)")
