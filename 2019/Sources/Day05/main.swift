func runProgram(memory: [Int], input: Int) -> Int {
    var memory = memory
    var ip = 0
    var output = 0
    while true {
        let opCode = memory[ip] % 100
        switch opCode {
        case 99:
            return output
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
            memory[memory[ip + 1]] = input
            ip += 2
        case 4:
            let parameter0 = (memory[ip] / 100) % 10 == 0 ? memory[memory[ip + 1]] : memory[ip + 1]
            output = parameter0
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

print("Part 1: \(runProgram(memory: input, input: 1))")
print("Part 2: \(runProgram(memory: input, input: 5))")
