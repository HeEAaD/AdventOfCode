import Foundation

let numbers = input
	.split(whereSeparator: \.isNewline)
	.map { $0.map { $0 } }

var signs = Array(repeating: 0, count: numbers[0].count)
for number in numbers {
	for (i, char) in number.enumerated() {
		switch char {
		case "1":
			signs[i] += 1
		case "0":
			signs[i] -= 1
		default:
			fatalError()
		}
	}
}

var gamma = 0
var epsilon = 0
for (i, e) in signs.reversed().enumerated() {
	if e > 0 {
		gamma += Int(pow(2, Double(i)))
	} else if e < 0 {
		epsilon += Int(pow(2, Double(i)))
	} else {
		fatalError()
	}
}

print("Answer 1: \(gamma * epsilon)")

func findNumber(in numbers: [[Substring.Element]], condition: (Int) -> Bool) -> [Substring.Element] {
	var numbers = numbers
	for i in 0..<numbers[0].count {
		var sign = 0
		for number in numbers {
			switch number[i] {
			case "1":
				sign += 1
			case "0":
				sign -= 1
			default:
				fatalError()
			}
		}

		if condition(sign) {
			numbers = numbers.filter { $0[i] == "1" }
		} else {
			numbers = numbers.filter { $0[i] == "0" }
		}

		if numbers.count == 1 {
			return numbers[0]
		}
	}
	fatalError()
}

func int(of number: [Substring.Element]) -> Int {
	var integer = 0
	for (i, e) in number.reversed().enumerated() where e == "1" {
		integer += Int(pow(2, Double(i)))
	}
	return integer
}

let oxygenNumber = findNumber(in: numbers, condition: { $0 >= 0 })
let co2ScrubberNumber = findNumber(in: numbers, condition: { $0 < 0 })

print("Answer 2: \(int(of: oxygenNumber) * int(of: co2ScrubberNumber))")
