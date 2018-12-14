func task1() -> String {
    var scores = [3, 7]
    var elves = [0, 1]
    let input = 190221
    while scores.count < input + 10 {
        let sum = elves.reduce(0) { $0 + scores[$1] }
        if sum >= 10 {
            scores.append(sum / 10)
            scores.append(sum % 10)
        } else {
            scores.append(sum)
        }

        elves = elves.map { elve in
            return (elve + 1 + scores[elve]) % scores.count
        }
    }

    var result = ""
    for score in scores[input..<input+10] {
        result.append(contentsOf: String(score))
    }
    return result
}

print("Task1: \(task1())")

func task2() -> Int {
    var scores = [3, 7]
    var elves = [0, 1]
    let input = [1, 9, 0, 2, 2, 1]
    while true {
        let sum = elves.reduce(0) { $0 + scores[$1] }
        if sum >= 10 {
            scores.append(sum / 10)
            scores.append(sum % 10)
        } else {
            scores.append(sum)
        }

        elves = elves.map { elve in
            return (elve + 1 + scores[elve]) % scores.count
        }

        if scores.count <= input.count {
            continue
        }
        if Array(scores[(scores.count - input.count)..<scores.count]) == input {
            return scores.count - input.count
        }
        if Array(scores[(scores.count - input.count - 1)..<scores.count - 1]) == input {
            return scores.count - input.count - 1
        }
    }
    fatalError()
}

print("Task2: \(task2())")
