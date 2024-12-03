let corruptedMemory = input
let instructions = corruptedMemory
    .ranges(of: try Regex(#"mul\(\d+,\d+\)|do\(\)|don't\(\)"#))
    .map { corruptedMemory[$0] }

var sumAnswer1 = 0
var sumAnswer2 = 0
var enabled = true

for instruction in instructions {
    if instruction.hasPrefix("mul(") {
        let factorA = Int(instruction.split(separator: ",")[0].dropFirst(4))!
        let factorB = Int(instruction.split(separator: ",")[1].dropLast())!
        let product = factorA * factorB
        sumAnswer1 += product
        if enabled {
            sumAnswer2 += product
        }
    } else if instruction == "do()" {
        enabled = true
    } else if instruction == "don't()" {
        enabled = false
    } else {
        fatalError()
    }
}

print("Answer 1:", sumAnswer1)
print("Answer 2:", sumAnswer2)
