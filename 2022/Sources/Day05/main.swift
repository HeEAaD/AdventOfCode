import Foundation

let inputComponents = input.components(separatedBy: "\n\n")
let stacksInput = inputComponents[0]
let movesInput = inputComponents[1]
var stacks: [[Character]] = Array(repeating: [], count: Int(String(stacksInput.last!))!)

for line in stacksInput.split(whereSeparator: \.isNewline).dropLast().reversed() {
    for offset in stride(from: 1, to: line.count, by: 4) {
        let char = line[line.index(line.startIndex, offsetBy: offset)]
        if char != " " {
            stacks[offset / 4].append(char)
        }
    }
}

var stacksTask1 = stacks
var stacksTask2 = stacks

for line in movesInput.split(whereSeparator: \.isNewline) {
    let components = line.split(separator: " ")
    let movesCount = Int(components[1])!
    let sourceStackIndex = Int(components[3])! - 1
    let destinationStackIndex = Int(components[5])! - 1
    for _ in 0..<movesCount {
        stacksTask1[destinationStackIndex].append(stacksTask1[sourceStackIndex].removeLast())
    }
    let crates = stacksTask2[sourceStackIndex].suffix(movesCount)
    stacksTask2[sourceStackIndex].removeLast(movesCount)
    stacksTask2[destinationStackIndex].append(contentsOf: crates)
}

print("Answer 1:", String(stacksTask1.compactMap(\.last)))
print("Answer 2:", String(stacksTask2.compactMap(\.last)))
