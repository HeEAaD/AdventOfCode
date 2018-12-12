var pots = Array(repeating: false, count: input.count)
for (i, s) in input.enumerated() where s == "#" {
    pots[i] = true
}

let rules: [[Bool]: Bool] = rulesInput.split(separator: "\n").reduce([:]) { rules, line in
    let words = line.split(separator: " ")
    let key = words[0].map { $0 == "#" ? true : false }
    let value = words[2] == "#" ? true : false
    var rules = rules
    rules[key] = value
    return rules
}

func showPots(_ pots: [Bool]) {
    var line = ""
    for pod in pots {
        line.append(pod ? "#" : ".")
    }
    print(line)
}

func step(pots: [Bool], shift: Int) -> [Bool] {
    var newPots = Array(repeating: false, count: pots.count)
    for i in 0..<pots.count - 4 {
        let kernel = Array(pots[i..<i + 5])
        if let rule = rules[kernel] {
            newPots[i + 2 - shift] = rule
        }
    }
    return newPots
}

func sumPots(_ pots: [Bool], offset: Int) -> Int {
    return pots.enumerated().reduce(0) { sum, arg1 in
        let (i, pot) = arg1
        return pot ? sum + i + offset : sum
    }
}

func sumAfter(generations: Int, pots: [Bool]) -> Int {
    var pots = pots
    let padding = 100
    var offset = -padding
    let shift = 1
    pots.insert(contentsOf: Array(repeating: false, count: padding), at: 0)
    pots.append(contentsOf: Array(repeating: false, count: padding))
    for _ in 0..<generations {
        let newPots = step(pots: pots, shift: shift)
        pots = newPots
        offset += shift
    }
    return sumPots(pots, offset: offset)
}

print("Task 1: \(sumAfter(generations: 20, pots: pots))")

func sumAfterOptimized(generations: Int, pots: [Bool]) -> Int {
    var pots = pots
    let padding = 100
    var offset = -padding
    let shift = 1
    pots.insert(contentsOf: Array(repeating: false, count: padding), at: 0)
    pots.append(contentsOf: Array(repeating: false, count: padding))

    for gen in 0..<generations {
        let newPots = step(pots: pots, shift: shift)
        if newPots == pots {
            offset += generations - gen
            break
        }
        pots = newPots
        offset += shift
    }
    return sumPots(pots, offset: offset)
}

print("Task 2: \(sumAfterOptimized(generations: 50000000000, pots: pots))") // 4550000002111
