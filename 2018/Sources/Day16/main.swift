import Foundation

enum Instruction: CaseIterable {
    case addr
    case addi

    case mulr
    case muli

    case banr
    case bani

    case borr
    case bori

    case setr
    case seti

    case gtir
    case gtri
    case gtrr

    case eqir
    case eqri
    case eqrr

    func execute(registers: inout [Int], a: Int, b: Int, c: Int) {
        switch self {
        case .addr:
            registers[c] = registers[a] + registers[b]
        case .addi:
            registers[c] = registers[a] + b
        case .mulr:
            registers[c] = registers[a] * registers[b]
        case .muli:
            registers[c] = registers[a] * b
        case .banr:
            registers[c] = registers[a] & registers[b]
        case .bani:
            registers[c] = registers[a] & b
        case .borr:
            registers[c] = registers[a] | registers[b]
        case .bori:
            registers[c] = registers[a] | b
        case .setr:
            registers[c] = registers[a]
        case .seti:
            registers[c] = a
        case .gtir:
            registers[c] = a > registers[b] ? 1 : 0
        case .gtri:
            registers[c] = registers[a] > b ? 1 : 0
        case .gtrr:
            registers[c] = registers[a] > registers[b] ? 1 : 0
        case .eqir:
            registers[c] = a == registers[b] ? 1 : 0
        case .eqri:
            registers[c] = registers[a] == b ? 1 : 0
        case .eqrr:
            registers[c] = registers[a] == registers[b] ? 1 : 0
        }
    }
}

func possibleInstructions(before: [Int], rawInstruction: [Int], after: [Int]) -> Set<Instruction> {
    let a = rawInstruction[1]
    let b = rawInstruction[2]
    let c = rawInstruction[3]
    let instructions = Instruction.allCases.filter { instruction in
        var registers = before
        instruction.execute(registers: &registers, a: a, b: b, c: c)
        return registers == after
    }
    return Set(instructions)
}

func generateOpcodeMap(instructionsInput: String) -> [Int: Instruction] {
    var task1Sum = 0
    var samples = [Int: Set<Set<Instruction>>]()
    let splittedInput = instructionsInput.split(separator: "\n")
    for i in stride(from: 0, to: splittedInput.count, by: 3) {
        let before: [Int] = splittedInput[i].split(separator: " ").compactMap { word in
            let word = word.replacingOccurrences(of: "[", with: "")
                .replacingOccurrences(of: "]", with: "")
                .replacingOccurrences(of: ",", with: "")
            return Int(word)
        }
        let rawInstruction = splittedInput[i + 1].split(separator: " ").compactMap { Int($0) }
        let after: [Int] = splittedInput[i + 2].split(separator: " ").compactMap { word in
            let word = word.replacingOccurrences(of: "[", with: "")
                .replacingOccurrences(of: "]", with: "")
                .replacingOccurrences(of: ",", with: "")
            return Int(word)
        }

        assert(before.count == 4)
        assert(after.count == 4)
        assert(rawInstruction.count == 4)

        if samples[rawInstruction[0]] == nil {
            samples[rawInstruction[0]] = []
        }
        let possibleInstructionsSet = possibleInstructions(before: before, rawInstruction: rawInstruction, after: after)
        if possibleInstructionsSet.count >= 3 {
            task1Sum += 1
        }
        samples[rawInstruction[0]]?.insert(possibleInstructionsSet)
    }

    print("Task 1: \(task1Sum)")

    var opcodeMap = [Int: Instruction]()

    while !samples.isEmpty {
        let founds = samples.filter { $0.value.count == 1 && $0.value.first?.count == 1 }

        for found in founds {
            let instruction = found.value.first!.first!
            opcodeMap[found.key] = instruction
            samples[found.key] = nil
            for (key, value) in samples {
                let array: [Set<Instruction>] = value.map { instructions in
                    var instructions = instructions
                    instructions.remove(instruction)
                    return instructions
                }
                .filter { !$0.isEmpty }
                samples[key] = Set(array)
            }
        }
    }

    assert(opcodeMap.count == Set(opcodeMap.values).count)
    return opcodeMap
}

func run(program: [[Int]], opcodeMap: [Int: Instruction], registers: inout [Int]) {
    for line in program {
        let instruction = opcodeMap[line[0]]!
        instruction.execute(registers: &registers, a: line[1], b: line[2], c: line[3])
    }
}

assert(possibleInstructions(before: [3, 2, 1, 1], rawInstruction: [9, 2, 1, 2], after: [3, 2, 2, 1]) == Set([Instruction.mulr, .addi, .seti]))

let opcodeMap = generateOpcodeMap(instructionsInput: instructionsInput)

let program = programInput.split(separator: "\n").map { line in
    return line.split(separator: " ").compactMap { Int($0) }
}

var registers = [0, 0, 0, 0]
run(program: program, opcodeMap: opcodeMap, registers: &registers)
print("Task 2: \(registers[0])")
