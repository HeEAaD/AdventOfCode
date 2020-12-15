let input: [Int] = [15,12,0,14,3,1]

func nthNumber(input: [Int], n: Int) -> Int {
    var numbers: [Int: Int] = [:]
    var lastNumber = input.last!

    for (i, n) in input.enumerated().dropLast() {
        numbers[n] = i
    }

    for i in numbers.count..<n - 1 {
        if let lastI = numbers[lastNumber] {
            numbers[lastNumber] = i
            lastNumber = i - lastI
        } else {
            numbers[lastNumber] = i
            lastNumber = 0
        }
    }

    return lastNumber
}

print("Answer 1: \(nthNumber(input: input, n: 2020))")
print("Answer 2: \(nthNumber(input: input, n: 30000000))")
