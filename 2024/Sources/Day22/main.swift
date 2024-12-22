let initialNumbers: [Int] = input.split(whereSeparator: \.isNewline).map { Int($0)! }

let (sum, mostBananas) = await run()

print("Answer 1:", sum)
print("Answer 2:", mostBananas)

func run() async -> (Int, Int) {
    await withTaskGroup(of: (Int, [Sequence: Int]).self) { taskGroup in
        for initialNumber in initialNumbers {
            taskGroup.addTask {
                calculateSecretsAndPrices(initial: initialNumber, steps: 2000)
            }
        }
        let (sum, priceSums) = await taskGroup
            .reduce(into: (Int(0), [Sequence: Int]())) { partialResult, numberAndPriceSums in
                partialResult.0 += numberAndPriceSums.0
                for (key, value) in numberAndPriceSums.1 {
                    partialResult.1[key, default: 0] += value
                }
            }
        let mostBananas = priceSums.max(by: { $0.value < $1.value })!.value
        return (sum, mostBananas)
    }
}

func calculateSecretsAndPrices(initial: Int, steps: Int) -> (Int, [Sequence: Int]) {
    var number = initial
    var visitedSequences: Set<Sequence> = []
    var priceSums: [Sequence: Int] = [:]

    var lastNumberLastDigit: Int8 = 0
    var lastDifference0: Int8 = .max
    var lastDifference1: Int8 = .max
    var lastDifference2: Int8 = .max

    for _ in 0..<steps {
        number = number ^ (number * 64) % 16777216
        number = number ^ (number / 32) % 16777216
        number = number ^ (number * 2048) % 16777216
        let lastDigit = Int8(number % 10)
        let difference = lastDigit - lastNumberLastDigit
        if lastDifference0 != .max {
            let lastDifferences = Sequence(a: lastDifference0, b: lastDifference1, c: lastDifference2, d: difference)
            if !visitedSequences.contains(lastDifferences) {
                visitedSequences.insert(lastDifferences)
                priceSums[lastDifferences, default: 0] += Int(lastDigit)
            }
        }

        lastDifference0 = lastDifference1
        lastDifference1 = lastDifference2
        lastDifference2 = difference
        lastNumberLastDigit = lastDigit
    }
    return (number, priceSums)
}

struct Sequence: Hashable {
    let a: Int8
    let b: Int8
    let c: Int8
    let d: Int8
}
