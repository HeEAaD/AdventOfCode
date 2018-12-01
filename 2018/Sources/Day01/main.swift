import Foundation

let fileURL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("input.txt")
var input = try String(contentsOf: fileURL).split(separator: "\n").compactMap { Int($0) }

let task1 = input.reduce(0, +)
print("Task1: \(task1)")

var seen: Set<Int> = [0]
var i = 0
var f = 0
while true {
    f += input[i]
    i = (i + 1) % input.count
    if seen.contains(f) {
        break
    }
    seen.insert(f)
}

print("Task2: \(f)")
