let lines = input.split(whereSeparator: \.isNewline)

var i = 50
var atZero = 0
var throughZero = 0

for line in lines {
    let isLeft = line.hasPrefix("L")
    assert(isLeft || line.hasPrefix("R"))

    var steps = Int(line.dropFirst())!
    throughZero += steps / 100
    steps %= 100

    if isLeft {
        if i != 0, steps > i {
            throughZero += 1
        }
        i -= steps
        if i < 0 {
            i += 100
        }
    } else {
        if i != 0, steps + i > 100 {
            throughZero += 1
        }
        i = (i + steps) % 100
    }

    if i == 0 {
        atZero += 1
    }
}

print("Answer 1: \(atZero)")
print("Answer 2: \(atZero + throughZero)")
