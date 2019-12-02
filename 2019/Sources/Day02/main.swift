func runProgram(memory: [Int], noun: Int, verb: Int) -> Int {
    var memory = memory
    memory[1] = noun
    memory[2] = verb
    var ip = 0
    while true {
        switch memory[ip] {
        case 99:
            return memory[0]
        case 1:
            memory[memory[ip + 3]] = memory[memory[ip + 1]] + memory[memory[ip + 2]]
        case 2:
            memory[memory[ip + 3]] = memory[memory[ip + 1]] * memory[memory[ip + 2]]
        default:
            fatalError()
        }
        ip += 4
    }
}

print("Part 1: \(runProgram(memory: input, noun: 12, verb: 2))")

func part2() {
    for noun in 0...99 {
        for verb in 0...99 {
            if runProgram(memory: input, noun: noun, verb: verb) == 19690720 {
                print("Part 2: \(100 * noun + verb)")
                return
            }
        }
    }
}

part2()
