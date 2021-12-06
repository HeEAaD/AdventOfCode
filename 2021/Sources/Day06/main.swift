var fishes = input.split(separator: ",").map { Int64($0)! }

func run(days: Int) -> Int64 {
	var fishesDict: [Int64: Int64] = [:]
	for fish in fishes {
		fishesDict[fish, default: 0] += 1
	}
	for _ in 0..<days {
		var newFishesDict: [Int64: Int64] = [:]
		for (key, value) in fishesDict {
			if key == 0 {
				newFishesDict[8, default: 0] += value
				newFishesDict[6, default: 0] += value
			} else {
				newFishesDict[key - 1, default: 0] += value
			}
		}
		fishesDict = newFishesDict
	}
	return fishesDict.values.reduce(0, +)
}

print("Answer 1: \(run(days: 80))")
print("Answer 1: \(run(days: 256))")
