import Foundation

let path = #file.components(separatedBy: "/Sources/main.swift").first! + "/Input/input.txt"
var instructions = try String(contentsOfFile: path)
    .components(separatedBy: .newlines)
    .filter { $0 != "" }
    .map { $0.components(separatedBy: .whitespaces) }

var p = 0

var r = [
    "a": 7,
    "b": 0,
    "c": 0,
    "d": 0
]

func toggle(offset: Int) {
    let targetP = p + offset
    if targetP < instructions.count && targetP > 0 {
        var targetInstruction = instructions[targetP]
        if targetInstruction.count == 2 {
            if targetInstruction[0] == "inc" {
               targetInstruction[0] = "dec"
            } else {
               targetInstruction[0] = "inc"
            }
        } else if targetInstruction.count == 3 {
            if targetInstruction[0] == "jnz" {
                targetInstruction[0] = "cpy"
            } else {
                targetInstruction[0] = "jnz"
            }
        }
        instructions[targetP] = targetInstruction
    }
}

func getValue(intOrR: String) -> Int? {
    return Int(intOrR) ?? r[intOrR]
}

func printSystem() {
    print("a: \(r["a"]!) b: \(r["b"]!) c: \(r["c"]!) d: \(r["d"]!) ")
    for (i, instruction) in instructions.enumerated() {
        let pd = i == p ? ">" : " "
        print("\(i)" + pd + instruction.joined(separator: " "))
    }
}

while p < instructions.count {
    let instruction = instructions[p]
//  printSystem()
    switch instruction[0] {
    case "cpy":
        if let value = getValue(intOrR: instruction[1]), r[instruction[2]] != nil {
            r[instruction[2]] = value
        }
        p += 1
    case "inc":
        if let value = r[instruction[1]] {
            r[instruction[1]] = value + 1
        }
        p += 1
    case "dec":
        if let value = r[instruction[1]] {
            r[instruction[1]] = value - 1
        }
        p += 1
    case "jnz":
        if let value = getValue(intOrR: instruction[1]), let offset = getValue(intOrR: instruction[2]) {
            p += value != 0 ? offset : 1
        }
    case "tgl":
        if let offset = getValue(intOrR: instruction[1]) {
            toggle(offset: offset)
        }
        p += 1
    default:
        fatalError()
    }
}

print("Task1: \(r["a"]!)") // 13140 = 7! + 90 * 90
// Task2: 12! + 90 * 90
