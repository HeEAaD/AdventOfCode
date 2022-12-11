import Foundation

struct Monkey {
    var items: [Int]
    var inspectCount = 0
    let operation: (Int) -> Int
    let testDivisor: Int
    let trueMonkey: Int
    let falseMonkey: Int
}

let monkeys = input
    .components(separatedBy: "\n\n")
    .enumerated()
    .map { index, description in
        let lines = description.split(whereSeparator: \.isNewline)
        precondition(Int(lines[0].split(separator: " ")[1].dropLast()) == index)
        let operationComponents = lines[2].split(separator: " ")
        let operation: (Int) -> Int
        switch (operationComponents[4], operationComponents[5]) {
        case ("*", "old"):
            operation = { $0 * $0 }
        case ("*", let factorString):
            let factor = Int(factorString)!
            operation = { $0 * factor }
        case ("+", let summandString):
            let summand = Int(summandString)!
            operation = { $0 + summand }
        default:
            fatalError()
        }
        return Monkey(
            items: lines[1].dropFirst(18).components(separatedBy: ", ").map { Int($0)! },
            operation: operation,
            testDivisor: Int(lines[3].dropFirst(21))!,
            trueMonkey: Int(lines[4].dropFirst(29))!,
            falseMonkey: Int(lines[5].dropFirst(30))!
        )
    }

func computeMonkeyBusiness(of monkeys: [Monkey], rounds: Int, divideByThree: Bool) -> Int {
    var monkeys = monkeys
    let commonMultiply = divideByThree ? 0 : monkeys.map(\.testDivisor).reduce(1, *)
    for _ in 0..<rounds {
        for monkeyIndex in 0..<monkeys.count {
            monkeys[monkeyIndex].inspectCount += monkeys[monkeyIndex].items.count
            for item in monkeys[monkeyIndex].items {
                let operation = monkeys[monkeyIndex].operation
                var worryLevel = operation(item)
                if divideByThree {
                    worryLevel /= 3
                } else {
                    worryLevel = worryLevel % commonMultiply
                }
                let targetIndex = worryLevel.isMultiple(of: monkeys[monkeyIndex].testDivisor) ? monkeys[monkeyIndex].trueMonkey : monkeys[monkeyIndex].falseMonkey
                monkeys[targetIndex].items.append(worryLevel)
            }
            monkeys[monkeyIndex].items = []
        }
    }
    let inspectCounts = monkeys.map(\.inspectCount).sorted(by: >)
    return inspectCounts[0] * inspectCounts[1]
}

print("Answer 1:", computeMonkeyBusiness(of: monkeys, rounds: 20, divideByThree: true))
print("Answer 2:", computeMonkeyBusiness(of: monkeys, rounds: 10000, divideByThree: false))
