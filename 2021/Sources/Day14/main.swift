let lines = input
    .split(whereSeparator: \.isNewline)

let rules = lines.dropFirst().reduce(into: [String: Character]()) { partialRules, line in
    let words = line.split(separator: " ")
    partialRules[String(words[0])] = words[2].first!
}

func minMaxLettersDiff(pairs:  [String : Int]) -> Int {
    var letters: [Character: Int] = [:]
    letters[lines[0].first!, default: 0] += 1
    letters[lines[0].last!, default: 0] += 1

    for pair in pairs {
        letters[pair.key.first!, default: 0] += pair.value
        letters[pair.key.last!, default: 0] += pair.value
    }

    return letters.values.max()! / 2 - letters.values.min()! / 2
}

var pairs: [String: Int] = [:]
for pair in zip(lines[0], lines[0].dropFirst()) {
    pairs[String(pair.0) + String(pair.1), default: 0] += 1
}

for step in 1...40 {
    var newPairs: [String: Int] = [:]
    for pair in pairs {
        if let rule = rules[pair.key] {
            newPairs[String(pair.key.first!) + String(rule), default: 0] += pair.value
            newPairs[String(rule) + String(pair.key.last!), default: 0] += pair.value
        } else {
            newPairs[pair.key, default: 0] += pair.value
        }
    }
    pairs = newPairs

    if step == 10 {
        print("Answer1", minMaxLettersDiff(pairs: pairs))
    }
}

print("Answer2", minMaxLettersDiff(pairs: pairs))
