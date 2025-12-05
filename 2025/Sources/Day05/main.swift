var isRanges = true
var ranges: [ClosedRange<UInt64>] = []
var ids: [UInt64] = []
for line in input.split(omittingEmptySubsequences: false, whereSeparator: \.isNewline) {
    if line.isEmpty {
        isRanges = false
        continue
    }
    if isRanges {
        let parts = line.split(separator: "-").map { UInt64($0)! }
        ranges.append(parts[0]...parts[1])
    } else {
        ids.append(UInt64(line)!)
    }
}

var merged = true
repeat {
    merged = false
    var newRanges: [ClosedRange<UInt64>] = [ranges[0]]
    for range in ranges.dropFirst() {
        for i in 0..<newRanges.count {
            if newRanges[i].overlaps(range)
               || newRanges[i].upperBound + 1 == range.lowerBound
               || newRanges[i].lowerBound - 1 == range.upperBound {
                let lowerBound = min(newRanges[i].lowerBound, range.lowerBound)
                let upperBound = max(newRanges[i].upperBound, range.upperBound)
                newRanges[i] = lowerBound...upperBound
                merged = true
                break
            } else if i == newRanges.count - 1 {
                newRanges.append(range)
            }
        }
    }
    ranges = newRanges
} while merged

let freshCount = ids.reduce(into: 0) { partialResult, id in
    let isFresh = ranges.contains(where: { $0.contains(id) })
    if isFresh {
        partialResult += 1
    }
}

print("Answer 1:", freshCount)

let mergedRangesSum = ranges.reduce(into: 0, { $0 += $1.count })
print("Answer 2:", mergedRangesSum)
