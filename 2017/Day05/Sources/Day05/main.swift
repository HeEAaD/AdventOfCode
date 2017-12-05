import Foundation

let path = ((#file as NSString).deletingLastPathComponent as NSString).appendingPathComponent("input.txt")
let input = try String(contentsOfFile: path)
    .components(separatedBy: .newlines)
    .filter { $0 != "" }
    .map { Int($0)! }

enum Task {
    case one
    case two
}

func run(offsets: [Int], task: Task) -> Int {
    var offsets = offsets
    var count = 0
    var i = 0
    while i >= 0 && i < offsets.count {
        let offset = offsets[i]
        let nextI = i + offsets[i]
        switch task {
        case .one:
            offsets[i] += 1
        case .two:
            offsets[i] += offset >= 3 ? -1 : 1
        }
        i = nextI
        count += 1
    }
    return count
}

print("Task 1: \(run(offsets: input, task: .one))")
print("Task 2: \(run(offsets: input, task: .two))")
