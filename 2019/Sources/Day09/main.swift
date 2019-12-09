
class Program {
    private var ip: Int64 = 0
    private var memory: [Int64]
    private let input: Pipe
    private let output: Pipe
    var isHalted = false
    private var relativeBase: Int64 = 0

    init(memory: [Int64], input: Pipe, output: Pipe) {
        self.memory = memory
        self.input = input
        self.output = output
    }

    private func mode(parameterPosition: Int64) -> Int64 {
        // requires Foundation
        // return (readMemory(ip) / Int64(pow(10, Double(parameterPosition + 2)))) % 10
        var q: Int64
        switch parameterPosition {
        case 0:
            q = 100
        case 1:
            q = 1000
        case 2:
            q = 10000
        default:
            fatalError()
        }
        return (readMemory(ip) / q) % 10
    }

    private func getParameter(_ position: Int64) -> Int64 {
        switch mode(parameterPosition: position) {
        case 0:
            return readMemory(readMemory(ip + 1 + position))
        case 1:
            return readMemory(ip + 1 + position)
        case 2:
            return readMemory(readMemory(ip + 1 + position) + relativeBase)
        default:
            fatalError()
        }
    }

    private func writeParameter(_ position: Int64, value: Int64) {
        switch mode(parameterPosition: position) {
        case 0:
            return writeMemory(readMemory(ip + 1 + position), value)
        case 2:
            return writeMemory(readMemory(ip + 1 + position) + relativeBase, value)
        default:
            fatalError("invalid write mode")
        }
    }

    private func readMemory(_ index: Int64) -> Int64 {
        precondition(index >= 0)
        if index > memory.count - 1 {
            return 0
        }
        return memory[Int(index)]
    }

    private func writeMemory(_ index: Int64, _ value: Int64) {
        precondition(index >= 0)
        if index > memory.count - 1 {
            memory.append(contentsOf: Array(repeating: Int64(0), count: Int(index) - memory.count + 1))
        }
        memory[Int(index)] = value
    }

    func tick() {
        guard !isHalted else { return }
        let opCode = readMemory(ip) % 100
        switch opCode {
        case 99:
            isHalted = true
        case 1:
            writeParameter(2, value: getParameter(0) + getParameter(1))
            ip += 4
        case 2:
            writeParameter(2, value: getParameter(0) * getParameter(1))
            ip += 4
        case 3:
            guard let nextInput = input.next() else { break }
            writeParameter(0, value: nextInput)
            ip += 2
        case 4:
            output.add(getParameter(0))
            ip += 2
        case 5:
            ip = getParameter(0) != 0 ? getParameter(1) : ip + 3
        case 6:
            ip = getParameter(0) == 0 ? getParameter(1) : ip + 3
        case 7:
            writeParameter(2, value: getParameter(0) < getParameter(1) ? 1 : 0)
            ip += 4
        case 8:
            writeParameter(2, value: getParameter(0) == getParameter(1) ? 1 : 0)
            ip += 4
        case 9:
            relativeBase += getParameter(0)
            ip += 2
        default:
            fatalError("invalid op code")
        }
    }
}

class Pipe: Sequence, IteratorProtocol {
    private var queue: [Int64] = []

    func add(_ element: Int64) {
        queue.append(element)
    }

    func next() -> Int64? {
        if queue.isEmpty {
            return nil
        } else {
            return queue.removeFirst()
        }
    }
}

func runProgram(programInput: Int64) -> [Int64] {
    let memory: [Int64] = input.map(Int64.init)
    let inputPipe = Pipe()
    inputPipe.add(programInput)
    let output = Pipe()
    let program = Program(memory: memory, input: inputPipe, output: output)
    while !program.isHalted {
        program.tick()
    }
    return Array(output)
}

print("Part 1: \(runProgram(programInput: 1)[0])")
print("Part 2: \(runProgram(programInput: 2)[0])")
