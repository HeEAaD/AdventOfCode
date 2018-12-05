let inputPolymer = input.compactMap { $0.unicodeScalars.first?.value }.map { Int8($0) }

func react(polymer: [Int8]) -> Int {
    var polymer = polymer
    var removed = false
    repeat {
        var newPolymer = [Int8]()
        removed = false
        var skipNext = false
        for i in 0..<polymer.count {
            guard !skipNext else {
                skipNext = false
                continue
            }
            if i != polymer.count - 1 && abs(polymer[i] - polymer[i + 1]) == 32 {
                skipNext = true
                removed = true
            } else {
                skipNext = false
                newPolymer.append(polymer[i])
            }
        }
        polymer = newPolymer
    } while removed
    return polymer.count
}

let length = react(polymer: inputPolymer)
print("Task 1: \(length)")

var shortest = Int.max
//       A    Z
for c in 65...90 {
    var removed = inputPolymer
    removed.removeAll { $0 == c || $0 == c + 32 }
    let length = react(polymer: removed)
    if length < shortest {
        shortest = length
    }
}
print("Task 2: \(shortest)")
