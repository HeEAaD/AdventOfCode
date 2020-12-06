let groups = input
    .split(omittingEmptySubsequences: false, whereSeparator: \.isNewline)
    .split(separator: "")

let sum1 = groups.reduce(into: 0) { sum, group in
    var groupAnswers: Set<Character> = []
    for line in group {
        groupAnswers.formUnion(Set(line))
    }
    sum += groupAnswers.count
}
print("Answer 1: \(sum1)")

let sum2 = groups.reduce(into: 0) { sum, group in
    var groupAnswers = Set(group.first!)
    for line in group.dropFirst() {
        for answer in groupAnswers where !line.contains(answer) {
            groupAnswers.remove(answer)
        }
    }
    sum += groupAnswers.count
}
print("Answer 2: \(sum2)")
