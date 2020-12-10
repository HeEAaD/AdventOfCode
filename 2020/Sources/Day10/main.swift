var adapters = input.split(whereSeparator: \.isNewline).map { Int($0)! }.sorted()

adapters.append(adapters.last! + 3)

var diff1Sum = 0
var diff3Sum = 0
var joltage = 0
var diff1RowCount = 1
var possibilities = 1
for adapter in adapters {
    switch adapter - joltage {
    case 1:
        diff1Sum += 1
        diff1RowCount += 1
    case 3:
        diff3Sum += 1
        switch diff1RowCount {
        case 1, 2:
            break
        case 3:
            possibilities *= 2
        case 4:
            possibilities *= 4
        case 5:
            possibilities *= 7
        default:
            fatalError("unsupported")
        }
        diff1RowCount = 1
    default:
        fatalError("invalid diff")
    }
    joltage = adapter
}

print("Answer 1: \(diff1Sum * diff3Sum)")
print("Answer 2: \(possibilities)")
