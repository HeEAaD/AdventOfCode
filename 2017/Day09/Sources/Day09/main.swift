import Foundation

let path = ((#file as NSString).deletingLastPathComponent as NSString).appendingPathComponent("input.txt")
let input = try String(contentsOfFile: path)

func run(_ input: String) -> (task1: Int, task2: Int) {

    var score = 0
    var garbageCount = 0

    var level = 0
    var ignoreNext = false
    var inGarbage = false
    
    for c in input {
        switch c {
        case "{" where !inGarbage && !ignoreNext:
            level += 1
        case "}" where !inGarbage && !ignoreNext:
            score += level
            level -= 1
        case "<" where !inGarbage && !ignoreNext:
            inGarbage = true
        case ">" where inGarbage && !ignoreNext:
            inGarbage = false
        case "!" where inGarbage && !ignoreNext:
            ignoreNext = true
        case _ where inGarbage && !ignoreNext:
            garbageCount += 1
        default:
            ignoreNext = false
        }
    }
    return (score, garbageCount)
}

let (task1, task2) = run(input)
print("Task1: \(task1)")
print("Task2: \(task2)")
