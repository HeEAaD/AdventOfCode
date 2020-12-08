enum Instruction {
    case jmp(Int)
    case acc(Int)
    case nop(Int)
}

let program: [Instruction] = input.split(whereSeparator: \.isNewline).map { line in
    let words = line.split(separator: " ")
    switch words[0] {
    case "jmp":
        return .jmp(Int(words[1])!)
    case "acc":
        return .acc(Int(words[1])!)
    case "nop":
        return .nop(Int(words[1])!)
    default:
        preconditionFailure("Unknown instruction")
    }
}

func run(program: [Instruction]) -> (accumulator: Int, isTerminated: Bool) {
    var ip = 0
    var accumulator = 0
    var visitedIPs: Set<Int> = [ip]

    while true {
        switch program[ip] {
        case .jmp(let offset):
            ip += offset
        case .acc(let offset):
            ip += 1
            accumulator += offset
        case .nop:
            ip += 1
        }
        if visitedIPs.contains(ip) {
            return (accumulator, false)
        } else if ip >= program.count {
            return (accumulator, true)
        }
        visitedIPs.insert(ip)
    }
}

print("Answer 1: \(run(program: program).accumulator)")

var fixedAccumulator = -1
for i in 0..<program.count {
    var fixedProgram = program
    switch program[i] {
    case .jmp(let offset):
        fixedProgram[i] = .nop(offset)
    case .acc:
        break
    case .nop(let offset):
        fixedProgram[i] = .jmp(offset)
    }

    let (accumulator, isTerminated) = run(program: fixedProgram)
    if isTerminated {
        fixedAccumulator = accumulator
        break
    }
}

print("Answer 2: \(fixedAccumulator)")
