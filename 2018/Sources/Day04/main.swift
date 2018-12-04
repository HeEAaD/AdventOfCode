let lines = input.split(separator: "\n").sorted()

var currentGuardId: Int = -1
var currentSleepStart: Int = -1
var sleepMins = [Int: [Int]]()
for line in lines {
    let words = line.split(separator: " ")
    switch words[2] {
    case "Guard":
        currentGuardId = Int(words[3].dropFirst())!
    case "falls":
        let word = words[1]
        currentSleepStart = Int(word[word.index(word.startIndex, offsetBy: 3)..<word.index(word.startIndex, offsetBy: 5)])!
    case "wakes":
        var mins = sleepMins[currentGuardId] ?? Array(repeating: 0, count: 60)
        let word = words[1]
        let currentSleepEnd = Int(word[word.index(word.startIndex, offsetBy: 3)..<word.index(word.startIndex, offsetBy: 5)])!
        for min in currentSleepStart..<currentSleepEnd {
            mins[min] += 1
        }
        sleepMins[currentGuardId] = mins
    default:
        preconditionFailure()
    }
}

let (guardId, mins) = sleepMins.max(by: { $0.value.reduce(0, +) < $1.value.reduce(0, +) })!
let maxMin = mins.enumerated().max(by: { $0.element < $1.element })!.offset
print("Task 1: \(guardId * maxMin)")

let (guardId2, mins2) = sleepMins.max(by: { $0.value.max()! < $1.value.max()! })!
let maxMin2 = mins2.enumerated().max(by: { $0.element < $1.element })!.offset
print("Task 2: \(guardId2 * maxMin2)")
