import Foundation

let path = ((#file as NSString).deletingLastPathComponent as NSString).appendingPathComponent("input.txt")
let input = try String(contentsOfFile: path).trimmingCharacters(in: .whitespacesAndNewlines)

var initPrograms = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p"]

enum Instruction {
    case spin(size: Int)
    case exchange(i: Int, j: Int)
    case partner(a: String, b: String)
}

let instructions: [Instruction] = input.split(separator: ",").map {
    switch $0.first {
    case "s"?:
        return Instruction.spin(size: Int($0.dropFirst())!)
    case "x"?:
        let subStrings = $0.dropFirst().split(separator: "/")
        return Instruction.exchange(i: Int(subStrings[0])!, j: Int(subStrings[1])!)
    case "p"?:
        let subStrings = $0.dropFirst().split(separator: "/")
        return Instruction.partner(a: String(subStrings[0]), b: String(subStrings[1]))
    default:
        fatalError()
    }
}

func run(_ instructions: [Instruction], rounds: Int) -> String {

    var programs = initPrograms
    var round = 0

    while round < rounds {
        round += 1

        for instruction in instructions {
            switch instruction {
            case let .spin(size: size):
                let suffix = programs.suffix(from: programs.count - size)
                programs.removeLast(size)
                programs.insert(contentsOf: suffix, at: 0)
            case let .exchange(i: i, j: j):
                programs.swapAt(i, j)
            case let .partner(a: a, b: b):
                let i = programs.index(of: a)!
                let j = programs.index(of: b)!
                programs.swapAt(i, j)
            }
        }

        // found cycle, fast forward
        if programs == initPrograms {
            round = rounds - (rounds % round)
        }
    }

    return programs.joined()
}

print("Task1: \(run(instructions, rounds: 1))")
print("Task2: \(run(instructions, rounds: 1_000_000_000))")
