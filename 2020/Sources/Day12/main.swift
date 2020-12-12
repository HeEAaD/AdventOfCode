let instructions = input.split(whereSeparator: \.isNewline)

var x = 0
var y = 0
var f = 90 // 0 == north

for instruction in instructions {
    let value = Int(instruction.dropFirst())!
    switch instruction.first! {
    case "F":
        switch f {
        case 0:
            y += value
        case 90:
            x += value
        case 180:
            y -= value
        case 270:
            x -= value
        default:
            preconditionFailure("invalid input")
        }
    case "N":
        y += value
    case "S":
        y -= value
    case "E":
        x += value
    case "W":
        x -= value
    case "L":
        f -= value
        if f < 0 {
            f += 360
        }
    case "R":
        f += value
        if f >= 360 {
            f -= 360
        }
    default:
        preconditionFailure("invalid input")
    }
}

print("Answer 1: \(abs(x) + abs(y))")

x = 0
y = 0
var wdx = 10
var wdy = 1

for instruction in instructions {
    switch (instruction.first!, Int(instruction.dropFirst())!) {
    case ("F", let value):
        x += wdx * value
        y += wdy * value
    case ("N", let value):
        wdy += value
    case ("S", let value):
        wdy -= value
    case ("E", let value):
        wdx += value
    case ("W", let value):
        wdx -= value
    case ("L", 90), ("R", 270):
        let twdx = wdx
        wdx = -wdy
        wdy = twdx
    case ("L", 180), ("R", 180):
        wdx = -wdx
        wdy = -wdy
    case ("L", 270), ("R", 90):
        let twdx = wdx
        wdx = wdy
        wdy = -twdx
    default:
        preconditionFailure("invalid input")
    }
}

print("Answer 2: \(abs(x) + abs(y))")
