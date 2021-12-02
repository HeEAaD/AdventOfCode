enum Instruction {
	case forward(Int)
	case down(Int)
	case up(Int)
}

let instructions = input
	.split(whereSeparator: \.isNewline)
	.map { line -> Instruction in
		let components = line.split(separator: " ")
		let x = Int(components[1])!
		switch components[0] {
		case "forward":
			return .forward(x)
		case "down":
			return .down(x)
		case "up":
			return .up(x)
		default:
			fatalError()
		}
	}

var depth = 0
var position = 0

for instruction in instructions {
	switch instruction {
	case .forward(let x):
		position += x
	case .down(let x):
		depth += x
	case .up(let x):
		depth -= x
	}
}

print("Answer 1: \(depth * position)")

var aim = 0
position = 0
depth = 0

for instruction in instructions {
	switch instruction {
	case .forward(let x):
		position += x
		depth += aim * x
	case .down(let x):
		aim += x
	case .up(let x):
		aim -= x
	}
}

print("Answer 2: \(depth * position)")
