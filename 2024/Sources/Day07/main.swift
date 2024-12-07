let equations: [(UInt64, [UInt64])] = input
    .split(whereSeparator: \.isNewline)
    .map { line in
        let parts = line.split(separator: " ")
        return (
            UInt64(parts[0].dropLast())!,
            parts.dropFirst().map { UInt64($0)! }
        )
    }

var sum1: UInt64 = 0
var sum2: UInt64 = 0
for equation in equations {
    if isValidEquation(equation, withConcat: false) {
        sum1 += equation.0
    }
    if isValidEquation(equation, withConcat: true) {
        sum2 += equation.0
    }
}
print("Answer 1:", sum1)
print("Answer 2:", sum2)

func isValidEquation(_ equation: (UInt64, [UInt64]), withConcat: Bool) -> Bool {
    let testValue = equation.0
    let numbers = equation.1
    var results: Set<UInt64> = [numbers[0]]

    for number in numbers.dropFirst() {
        var newResults: Set<UInt64> = []
        for result in results {
            let newResultAdd = result + number
            if newResultAdd <= testValue {
                newResults.insert(newResultAdd)
            }
            let newResultMultiply = result * number
            if newResultMultiply <= testValue {
                newResults.insert(newResultMultiply)
            }
            if withConcat {
                let newResultConcat = UInt64(String(result) + String(number))!
                if newResultConcat <= testValue {
                    newResults.insert(newResultConcat)
                }
            }
        }
        if newResults.isEmpty {
            return false
        }
        results = newResults
    }

    return results.contains(testValue)
}
