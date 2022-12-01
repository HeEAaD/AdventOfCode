var max0 = 0
var max1 = 0
var max2 = 0
var calories = 0

for line in input.split(omittingEmptySubsequences: false, whereSeparator: \.isNewline) {
    guard !line.isEmpty else {
        if calories >= max0 {
            max2 = max1
            max1 = max0
            max0 = calories
        } else if calories >= max1 {
            max2 = max1
            max1 = calories
        } else if calories > max2 {
            max2 = calories
        }
        calories = 0
        continue
    }
    calories += Int(line)!
}

print("Answer 1:", max0)
print("Answer 2:", max0 + max1 + max2)
