let lines = input.split(whereSeparator: \.isNewline).map { $0.map { $0 } }

let start = lines[0].firstIndex(of: "S")!
var timelines: [Int: Int64] = [start: 1]
var splits = 0

for lineI in stride(from: 2, to: lines.count, by: 2) {
    for (i, times) in timelines where lines[lineI][i] == "^" {
        timelines[i - 1, default: 0] += times
        timelines[i + 1, default: 0] += times
        timelines[i] = nil
        splits += 1
    }
}

print("Answer 1:", splits)
print("Answer 2:", timelines.values.reduce(0, +))
