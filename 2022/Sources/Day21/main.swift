enum Operation {
    case yell(Int64)
    case sum(String, String)
    case minus(String, String)
    case mult(String, String)
    case div(String, String)
}

var operations: [String: Operation] = [:]

for line in input.split(whereSeparator: \.isNewline) {
    let components = line.split(separator: " ")
    let id = String(components[0].dropLast())
    if components.count == 2 {
        operations[id] = .yell(Int64(components[1])!)
    } else if components[2] == "+" {
        operations[id] = .sum(String(components[1]), String(components[3]))
    } else if components[2] == "-" {
        operations[id] = .minus(String(components[1]), String(components[3]))
    } else if components[2] == "*" {
        operations[id] = .mult(String(components[1]), String(components[3]))
    } else if components[2] == "/" {
        operations[id] = .div(String(components[1]), String(components[3]))
    }
}

var stack = [operations["root"]]

func calc(_ operation: Operation) -> Int64 {
    switch operation {
    case .yell(let int):
        return int
    case .sum(let a, let b):
        return calc(operations[a]!) + calc(operations[b]!)
    case .minus(let a, let b):
        return calc(operations[a]!) - calc(operations[b]!)
    case .mult(let a, let b):
        return calc(operations[a]!) * calc(operations[b]!)
    case .div(let a, let b):
        return calc(operations[a]!) / calc(operations[b]!)
    }
}

print("Answer 1:", calc(operations["root"]!))

var equalA: String
var equalB: String
switch operations["root"]! {
case .yell:
    fatalError()
case let .sum(a, b),
    let .minus(a, b),
    let .mult(a, b),
    let .div(a, b):
    equalA = a
    equalB = b
}

func bruteForce(humn: Int64, step: Int64) -> (Int64, Bool) {
    let b = calc(operations[equalB]!)
    var humn = humn
    while true {
        humn += step
        operations["humn"] = .yell(humn)
        let a = calc(operations[equalA]!)
        if a == b {
            return (humn, true)
        } else if a < b {
            return (humn - step, false)
        }
    }
    fatalError()
}

var humn: Int64 = 0
var step: Int64 = 1_000_000_000_000
var found = false
while true {
    (humn, found) = bruteForce(humn: humn, step: step)
    if found {
        break
    }
    step /= 10
}

print("Answer 2:", humn)
