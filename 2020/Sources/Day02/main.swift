struct Policy {
    let min: Int
    let max: Int
    let char: Character
    let password: Substring
}

//let lines = sampleInput.split(whereSeparator: \.isNewline)
let lines = input.split(whereSeparator: \.isNewline)
let policies = lines.map { line -> Policy in
    let words = line.split(separator: " ")
    let range = words[0].split(separator: "-")
    return Policy(min: Int(range[0])!,
                  max: Int(range[1])!,
                  char: words[1][words[1].startIndex],
                  password: words[2])
}

let validPasswordCount1 = policies.reduce(0) { count, policy -> Int in
    let charCount = policy.password.reduce(0) { $1 == policy.char ? $0 + 1 : $0 }
    return (policy.min...policy.max).contains(charCount) ? count + 1 : count
}

print("Answer 1: \(validPasswordCount1)")

let validPasswordCount2 = policies.reduce(0) { count, policy -> Int in
    let minChar = policy.password[policy.password.index(policy.password.startIndex, offsetBy: policy.min - 1)]
    let maxChar = policy.password[policy.password.index(policy.password.startIndex, offsetBy: policy.max - 1)]
    return (minChar == policy.char) != (maxChar == policy.char) ? count + 1 : count
}

print("Answer 2: \(validPasswordCount2)")
