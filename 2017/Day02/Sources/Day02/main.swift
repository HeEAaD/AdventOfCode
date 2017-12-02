import Foundation

let path = ((#file as NSString).deletingLastPathComponent as NSString).appendingPathComponent("input.txt")
var input = try String(contentsOfFile: path)
    .components(separatedBy: .newlines)
    .filter { $0 != "" }
    .map { $0.components(separatedBy: "\t").map { Int($0)! } }

// naive, O(n^2)
func evenlyDividableDiff(array: [Int]) -> Int {
    for i in 0..<array.count {
        for j in 0..<array.count where i != j {
            let a = array[i]
            let b = array[j]
            if a % b == 0 {
                return a / b
            }
        }
    }
    preconditionFailure()
}

let task1 = input.reduce(0) { $0 + $1.max()! - $1.min()! }
print("Task 1: \(task1)")

let task2 = input.reduce(0) { $0 + evenlyDividableDiff(array: $1) }
print("Task 2: \(task2)")
