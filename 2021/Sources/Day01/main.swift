let depths = input.split(whereSeparator: \.isNewline).map { Int($0)! }

var increaseCount = 0
for i in 1..<depths.count where depths[i-1] < depths[i] {
	increaseCount += 1
}
print("Answer 1: \(increaseCount)")

increaseCount = 0
var lastWindowSum = Int.max
for i in 0..<depths.count-2 {
	let windowSum = depths[i] + depths[i+1] + depths[i+2]
	if lastWindowSum < windowSum {
		increaseCount += 1
	}
	lastWindowSum = windowSum
}
print("Answer 2: \(increaseCount)")
