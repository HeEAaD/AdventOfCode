import Foundation

let path = #file.components(separatedBy: "/Sources/main.swift").first! + "/Input/task1.txt"
let input = try String(contentsOfFile: path)
    .components(separatedBy: .newlines)
    .filter { $0 != "" }
    .map {
        $0.components(separatedBy: .whitespaces)
        .filter { $0 != "" }
        .map { Int($0)! }
    }

func validTryAngle(sides: [Int]) -> Bool {
    assert(sides.count == 3)
    let sides = sides.sorted()
    return sides[0] + sides[1] > sides[2]
}

// MARK: Task1

let task1 = input.reduce(0) { validTryAngles, sides in
    if validTryAngle(sides: sides) {
        return validTryAngles + 1
    }
    return validTryAngles
}

print("Task 1: \(task1)") // 993

// MARK: Task2

assert(input.count % 3 == 0)
var task2 = 0
for i in stride(from: 0, to: input.count-2, by: 3) {
    for j in 0...2 {
        if validTryAngle(sides: [input[i][j], input[i+1][j], input[i+2][j]]) {
            task2 += 1
        }
    }
}

print("Task 2: \(task2)") // 1849
