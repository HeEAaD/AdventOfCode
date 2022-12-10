var x = 1
var row = ""
var rows: [String] = []
var strengthSum = 0
var meassureStrengthCycles: Set = [20, 60, 100, 140, 180, 220]
var cycle = 0 { didSet { inspect() }}

func inspect() {
    row += (x-1...x+1).contains(row.count) ? "#" : " "
    if cycle.isMultiple(of: 40) {
        rows.append(row)
        row = ""
    }
    if meassureStrengthCycles.contains(cycle) {
        strengthSum += cycle * x
    }
}

for line in input.split(whereSeparator: \.isNewline) {
    let components = line.split(separator: " ")
    switch components[0] {
    case "noop":
        cycle += 1
    case "addx":
        cycle += 1
        cycle += 1
        x += Int(components[1])!
    default:
        fatalError()
    }
}

print("Answer 1:", strengthSum)
print("Answer 2:")
for row in rows {
    print(row)
}
