let lines = input.split(whereSeparator: \.isNewline).map { $0.map { $0 } }

let task1Sum = lines.reduce(into: 0) { sum, line in
    sum += Set(line[0 ..< line.count / 2])
        .intersection(Set(line[line.count / 2 ..< line.count]))
        .first!
        .priority
}
print("Answer 1:", task1Sum)

let task2Sum = stride(from: 0, to: lines.count, by: 3).reduce(into: 0) { sum, index in
    sum += Set(lines[index])
        .intersection(Set(lines[index + 1]))
        .intersection(Set(lines[index + 2]))
        .first!
        .priority
}
print("Answer 2:", task2Sum)

private extension Character {
    var priority: Int {
        switch self {
        case "a"..."z":
            return Int(self.asciiValue!) - 96
        case "A"..."Z":
            return Int(self.asciiValue!) - 38
        default:
            fatalError()
        }
    }
}
