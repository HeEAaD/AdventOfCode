import Foundation

let path = ((#file as NSString).deletingLastPathComponent as NSString).appendingPathComponent("input.txt")
let input = try String(contentsOfFile: path)
    .components(separatedBy: .newlines)
    .filter { $0 != "" }
    .map { $0.split(separator: " ").map { String($0) } }

func run(instructions: [[String]]) -> (task1: Int, task2: Int) {

    var registers = [String: Int]()

    var highestValue = Int.min

    for instruction in instructions {
        let refValue = registers[instruction[4]] ?? 0
        let shouldValue = Int(instruction[6])!

        switch instruction[5] {
        case ">" where refValue > shouldValue,
             "<" where refValue < shouldValue,
             ">=" where refValue >= shouldValue,
             "==" where refValue == shouldValue,
             "<=" where refValue <= shouldValue,
             "!=" where refValue != shouldValue:

            let registerKey = instruction[0]

            switch instruction[1] {
            case "inc":
                registers[registerKey] = (registers[registerKey] ?? 0) + Int(instruction[2])!
                highestValue = max(highestValue, registers[registerKey]!)
            case "dec":
                registers[registerKey] = (registers[registerKey] ?? 0) - Int(instruction[2])!
                highestValue = max(highestValue, registers[registerKey]!)
            default:
                fatalError()
            }

        default:
            continue
        }
    }

    let task1 = registers.max { $0.value < $1.value }!.value
    return (task1, highestValue)
}

let (task1, task2) = run(instructions: input)
print("Task 1: \(task1)")
print("Task 2: \(task2)")
