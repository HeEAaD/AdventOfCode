let rules: [Int: Set<Int>] = inputRules
    .split(whereSeparator: \.isNewline)
    .reduce(into: [:]) { rules, rawRule in
        let components = rawRule.split(separator: "|").map { Int($0)! }
        precondition(components.count == 2)
        rules[components[0], default: []].insert(components[1])
    }

let updates: [[Int]] = inputUpdates
    .split(whereSeparator: \.isNewline)
    .map {
        $0.split(separator: ",").map { Int($0)! }
    }

var sumValid = 0
var sumInvalid = 0
for update in updates {
    if isValidUpdate(update, rules) {
        sumValid += middlePageNumber(update)
    } else {
        let sortedUpdate = update.sorted { lhs, rhs -> Bool in
            rules[lhs]?.contains(rhs) == true
        }
        sumInvalid += middlePageNumber(sortedUpdate)
    }
}

print("Answer 1:", sumValid)
print("Answer 2:", sumInvalid)

// MARK: - Methods

func isValidUpdate(_ update: [Int], _ rules: [Int: Set<Int>]) -> Bool {
    guard update.count > 1 else { return true }
    for i in 0..<update.count - 1 {
        for j in i+1..<update.count {
            if rules[update[j]]?.contains(update[i]) == true {
                return false
            }
        }
    }
    return true
}

func middlePageNumber(_ update: [Int]) -> Int {
    update[update.count / 2]
}
