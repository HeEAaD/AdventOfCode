import Foundation

let path = #file.components(separatedBy: "/Sources/main.swift").first! + "/Input/Input.txt"
let instructions = try String(contentsOfFile: path)
    .components(separatedBy: .newlines)
    .filter { $0 != "" }
    .map { $0.components(separatedBy: .whitespaces) }

var p = 0

var r = [
    "a": 0,
    "b": 0,
    "c": 0, // 1,
    "d": 0,
]

while p < instructions.count {
    let instruction = instructions[p]

    switch instruction[0] {
    case "cpy":
        if let int = Int(instruction[1]) {
            r[instruction[2]] = int
        } else {
            r[instruction[2]] = r[instruction[1]]
        }
        p += 1
    case "inc":
        r[instruction[1]] = r[instruction[1]]! + 1
        p += 1
    case "dec":
        r[instruction[1]] = r[instruction[1]]! - 1
        p += 1
    case "jnz":
        if let int = Int(instruction[1]) {
            p += int != 0 ? Int(instruction[2])! as Int : 1
        } else {
            p += r[instruction[1]]! != 0 ? Int(instruction[2])! as Int : 1
        }
    default:
        fatalError()
    }
}

print("Task1: \(r["a"]!)") // 318007
