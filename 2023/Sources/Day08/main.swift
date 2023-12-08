import Foundation

let components = input.components(separatedBy: "\n\n")
let instructions = Array(components[0])

var nodes: [String: (left: String, right: String)] = [:]
components[1].split(separator: "\n").forEach { line in
    let components = line.components(separatedBy: " ")
    let node = components[0]
    let left = String(components[2].dropFirst().dropLast())
    let right = String(components[3].dropLast())
    nodes[node] = (left, right)
}

print("Answer 1:", stepsToEnd(start: "AAA"))

let elements = nodes.keys.filter { $0.hasSuffix("A") }
let steps = elements.map(stepsToEnd(start:))
let result = steps.dropFirst().reduce(steps[0]) {
    lcm($0, $1)
}
print("Answer 2:", result)

func stepsToEnd(start: String) -> Int {
    var element = start
    var instructionCount = 0
    while true {
        let instruction = instructions[instructionCount % instructions.count]
        switch instruction {
        case "L":
            element = nodes[element]!.left
        case "R":
            element = nodes[element]!.right
        default:
            fatalError()
        }
        instructionCount += 1
        if element.hasSuffix("Z") {
            break
        }
    }
    return instructionCount
}

func gcd(_ x: Int, _ y: Int) -> Int {
    var a = 0
    var b = max(x, y)
    var r = min(x, y)

    while r != 0 {
        a = b
        b = r
        r = a % b
    }
    return b
}

func lcm(_ x: Int, _ y: Int) -> Int {
    return x / gcd(x, y) * y
}
