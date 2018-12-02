let ids = input.split(separator: "\n")

// MARK: Task 1

let twosThrees = ids.reduce((0, 0)) { (twosThrees, id) -> (Int, Int) in
    var (twos, threes) = twosThrees
    var charCounts = [Character: Int]()
    for c in id {
        charCounts[c] = (charCounts[c] ?? 0) + 1
    }
    twos += charCounts.values.contains(2) ? 1 : 0
    threes += charCounts.values.contains(3) ? 1 : 0
    return (twos, threes)
}

print("Task1: \(twosThrees.0 * twosThrees.1)")

// MARK: Task 2

// naive O(n^2)
func task2() -> String {
    for i in 0..<ids.count - 1 {
        var lhs = ids[i]
        for j in i + 1..<ids.count {
            let rhs = ids[j]
            var diffI = -1
            var found = true
            for (lhsi, c) in lhs.enumerated() where c != rhs[rhs.index(rhs.startIndex, offsetBy: lhsi)] {
                if diffI != -1 {
                    found = false
                    break
                } else {
                    diffI = lhsi
                }
            }

            if found {
                lhs.remove(at: lhs.index(lhs.startIndex, offsetBy: diffI))
                return String(lhs)
            }
        }
    }
    preconditionFailure()
}

print("Task2: \(task2())")
