import Foundation

let path = #file.components(separatedBy: "/Sources/main.swift").first! + "/Input/Input.txt"
let input = try String(contentsOfFile: path)
    .components(separatedBy: .newlines)
    .filter { $0 != "" }

var counts = Array(repeating: [Character:Int](), count: input[0].characters.count)

for line in input {
    for (i, char) in line.characters.enumerated() {

        if let count = counts[i][char] {
            counts[i][char] = count + 1
        } else {
            counts[i][char] = 1
        }
    }
}

let increasing: ((Character, Int), (Character, Int)) -> Bool = { $0.1 < $1.1 }

let task1 = String(counts.map { $0.max(by: increasing)!.key })
print("Task 1: \(task1)") // gebzfnbt

let task2 = String(counts.map { $0.min(by: increasing)!.key })
print("Task 2: \(task2)") // fykjtwyn
