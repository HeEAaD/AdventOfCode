class Program {
    var ip = 0
    var memory: [Int]
    var input: Pipe
    var output: Pipe
    var isHalted = false

    init(memory: [Int], input: Pipe, output: Pipe) {
        self.memory = memory
        self.input = input
        self.output = output
    }

    func tick() {
        guard !isHalted else { return }
        let opCode = memory[ip] % 100
        switch opCode {
        case 99:
            isHalted = true
        case 1:
            let parameter0 = (memory[ip] / 100) % 10 == 0 ? memory[memory[ip + 1]] : memory[ip + 1]
            let parameter1 = (memory[ip] / 1000) % 10 == 0 ? memory[memory[ip + 2]] : memory[ip + 2]
            memory[memory[ip + 3]] = parameter0 + parameter1
            ip += 4
        case 2:
            let parameter0 = (memory[ip] / 100) % 10 == 0 ? memory[memory[ip + 1]] : memory[ip + 1]
            let parameter1 = (memory[ip] / 1000) % 10 == 0 ? memory[memory[ip + 2]] : memory[ip + 2]
            memory[memory[ip + 3]] = parameter0 * parameter1
            ip += 4
        case 3:
            if let nextInput = input.next() {
                memory[memory[ip + 1]] = nextInput
                ip += 2
            }
        case 4:
            let parameter0 = (memory[ip] / 100) % 10 == 0 ? memory[memory[ip + 1]] : memory[ip + 1]
            output.add(parameter0)
            ip += 2
        case 5:
            let parameter0 = (memory[ip] / 100) % 10 == 0 ? memory[memory[ip + 1]] : memory[ip + 1]
            let parameter1 = (memory[ip] / 1000) % 10 == 0 ? memory[memory[ip + 2]] : memory[ip + 2]
            ip = parameter0 != 0 ? parameter1 : ip + 3
        case 6:
            let parameter0 = (memory[ip] / 100) % 10 == 0 ? memory[memory[ip + 1]] : memory[ip + 1]
            let parameter1 = (memory[ip] / 1000) % 10 == 0 ? memory[memory[ip + 2]] : memory[ip + 2]
            ip = parameter0 == 0 ? parameter1 : ip + 3
        case 7:
            let parameter0 = (memory[ip] / 100) % 10 == 0 ? memory[memory[ip + 1]] : memory[ip + 1]
            let parameter1 = (memory[ip] / 1000) % 10 == 0 ? memory[memory[ip + 2]] : memory[ip + 2]
            memory[memory[ip + 3]] = parameter0 < parameter1 ? 1 : 0
            ip += 4
        case 8:
            let parameter0 = (memory[ip] / 100) % 10 == 0 ? memory[memory[ip + 1]] : memory[ip + 1]
            let parameter1 = (memory[ip] / 1000) % 10 == 0 ? memory[memory[ip + 2]] : memory[ip + 2]
            memory[memory[ip + 3]] = parameter0 == parameter1 ? 1 : 0
            ip += 4
        default:
            fatalError()
        }
    }
}

class Pipe: Sequence, IteratorProtocol {
    private var queue: [Int] = []

    func add(_ element: Int) {
        queue.append(element)
    }

    func next() -> Int? {
        if queue.isEmpty {
            return nil
        } else {
            return queue.removeFirst()
        }
    }
}

extension Array {
    var permutations: [[Element]] {
        var result = [[Element]]()
        func step(_ n: Int, _ a: inout [Element]) {
            guard n > 1 else {
                result.append(a)
                return
            }
            for i in 0..<n-1 {
                step(n-1, &a)
                a.swapAt(n-1, (n%2 == 1) ? 0 : i)
            }
            step(n-1, &a)
        }
        var mutatingSelf = self
        step(mutatingSelf.count, &mutatingSelf)
        return result
    }
}

func thrusterOutput(memory: [Int], phaseSettings: [Int], isLooped: Bool) -> Int {
    let inputs: [Pipe] = phaseSettings.map { phaseSetting in
        let pipe = Pipe()
        pipe.add(phaseSetting)
        return pipe
    }
    let output = isLooped ? inputs[0] : Pipe()
    var outputs = Array(inputs.dropFirst())
    outputs.append(output)

    let programs = zip(inputs, outputs).map { input, output in
        return Program(memory: memory, input: input, output: output)
    }

    inputs[0].add(0)

    while !programs[programs.count - 1].isHalted {
        programs.forEach { $0.tick() }
    }

    var thrusterOutput = 0
    while let next = output.next() {
        thrusterOutput = next
    }
    return thrusterOutput
}

var phaseSettings = [0,1,2,3,4].permutations
var maxOutput = phaseSettings.map { thrusterOutput(memory: input, phaseSettings: $0, isLooped: false) }.max()!
print("Part 1: \(maxOutput)")

phaseSettings = [5,6,7,8,9].permutations
maxOutput = phaseSettings.map { thrusterOutput(memory: input, phaseSettings: $0, isLooped: true) }.max()!
print("Part 2: \(maxOutput)")
