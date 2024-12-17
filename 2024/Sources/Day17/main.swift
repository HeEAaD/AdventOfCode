let registerA: Int = Int((input.firstMatch(of: /Register A: (\d+)/)!.1))!
let registerB: Int = Int((input.firstMatch(of: /Register B: (\d+)/)!.1))!
let registerC: Int = Int((input.firstMatch(of: /Register C: (\d+)/)!.1))!
let program: [Int] = input.firstMatch(of: /Program: ((\d,)*\d)/)!.1.split(separator: ",").map { Int($0)! }

let output = run(program, a: registerA, b: registerB, c: registerC)
print("Answer 1:", output.map { String($0) }.joined(separator: ","))

var stack: [[Int]] = [[]]
var results: [[Int]] = []
while let aComponents = stack.popLast() {
    var stackTmp: [[Int]] = []
    for i in 0...7 {
        let newAComponents = aComponents + [i]
        let aBase2 = newAComponents
            .map {
                let s = String($0, radix: 2)
                return Array(repeating: "0", count: 3-s.count).joined() + s
            }
            .joined()

        let output = run(program, a: Int(aBase2, radix: 2)!, b: registerB, c: registerC)
        if zip(output.reversed(), program.reversed()).allSatisfy({ $0 == $1 }), output.count == newAComponents.count {
            if output.count == program.count {
                results.append(newAComponents)
            } else {
                stackTmp.append(newAComponents)
            }
        }
    }
    stack.append(contentsOf: stackTmp)
}

let answer = results.map { result -> Int in
    let resultBase2 = result
        .map {
            let s = String($0, radix: 2)
            return Array(repeating: "0", count: 3-s.count).joined() + s
        }
        .joined()
    let resultBase10 = Int(resultBase2, radix: 2)!
    return resultBase10
}.min()!

print("Answer 2:", answer)

func run(_ program: [Int], a: Int, b: Int, c: Int) -> [Int] {
    var instructionPointer = 0
    var registerA = a
    var registerB = b
    var registerC = c

    let comboOperand: (Int) -> Int = { i in
        return switch program[i] {
        case 0...3:
            program[i]
        case 4:
            registerA
        case 5:
            registerB
        case 6:
            registerC
        case 7:
            fatalError("reserved")
        default:
            fatalError()
        }
    }

    var output: [Int] = []

    while instructionPointer < program.count {
        let instruction = program[instructionPointer]
        switch instruction {
        case 0: // adv
            registerA = registerA / (1 << comboOperand(instructionPointer + 1))
            instructionPointer += 2
        case 1: // bxl
            registerB = registerB ^ program[instructionPointer + 1]
            instructionPointer += 2
        case 2: // bst
            registerB = comboOperand(instructionPointer + 1) % 8
            instructionPointer += 2
        case 3: // jnz
            if registerA == 0 {
                instructionPointer += 2
            } else {
                instructionPointer = program[instructionPointer + 1]
            }
        case 4: // bxc
            registerB = registerB ^ registerC
            instructionPointer += 2
        case 5: // out
            output.append(comboOperand(instructionPointer + 1) % 8)
            instructionPointer += 2
        case 6: // bdv
            registerB = registerA / (1 << comboOperand(instructionPointer + 1))
            instructionPointer += 2
        case 7: // cdv
            registerC = registerA / (1 << comboOperand(instructionPointer + 1))
            instructionPointer += 2
        default:
            fatalError()
        }
    }

    return output
}
