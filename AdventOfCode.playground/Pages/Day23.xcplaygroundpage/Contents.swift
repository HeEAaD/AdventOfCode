import Foundation

let path = NSBundle.mainBundle().pathForResource("instructions", ofType: nil)
let instructions = try! String(contentsOfFile: path!)
    .stringByReplacingOccurrencesOfString(",", withString: "")
    .componentsSeparatedByString("\n")
    .map { $0.componentsSeparatedByString(" ")}

func runProgram(var register:[String:Int]) -> [String:Int] {
    var instructionPointer = 0
    while instructionPointer < instructions.count {
        switch instructions[instructionPointer] {
        case let i where i[0] == "hlf":
            register[i[1]]! /= 2
            instructionPointer += 1
        case let i where i[0] == "tpl":
            register[i[1]]! *= 3
            instructionPointer += 1
        case let i where i[0] == "inc":
            register[i[1]]! += 1
            instructionPointer += 1
        case let i where i[0] == "jmp":
            instructionPointer += Int(i[1])!
        case let i where i[0] == "jie":
            instructionPointer += register[i[1]]! % 2 == 0 ? Int(i[2])! : 1
        case let i where i[0] == "jio":
            instructionPointer += register[i[1]]! == 1 ? Int(i[2])! : 1
        default: break
        }
    }
    return register
}

print("Task 1: \(runProgram([ "a" : 0, "b" : 0])["b"]!)")
print("Task 2: \(runProgram([ "a" : 1, "b" : 0])["b"]!)")
