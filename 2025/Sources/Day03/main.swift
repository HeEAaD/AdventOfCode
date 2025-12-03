func getDigit(bank: [UInt8], startI: Int, endI: Int) -> (offset: Int, digit: UInt8) {
    let max = bank[startI...endI]
        .enumerated()
        .max(by: { $0.element < $1.element })!

    return (max.offset + startI, max.element)
}

func joltage(digits: Int, bank: [UInt8]) -> Int {
    var startI = 0
    var joltageDigits: [UInt8] = []
    for i in 0..<digits {
        let (offset, digit) = getDigit(bank: bank, startI: startI, endI: bank.count - digits + i)
        startI = offset + 1
        joltageDigits.append(digit)
    }

    var joltage = 0
    var factor = 1
    for d in joltageDigits.reversed() {
        joltage += Int(d) * factor
        factor *= 10
    }
    return joltage
}

let banks = input
    .split(whereSeparator: \.isNewline)
    .map { $0.map { UInt8(String($0))! } }

let joltageSums = banks.reduce(into: (0, 0)) { partialResult, bank in
    partialResult.0 += joltage(digits: 2, bank: bank)
    partialResult.1 += joltage(digits: 12, bank: bank)
}

print("Answer 1:", joltageSums.0)
print("Answer 2:", joltageSums.1)
