let input = "364297581"

let cups = input.map { Int(String($0))! }

// naive takes hours to complete
func play(cups: [Int], moves: Int, afterOne: Int) -> [Int] {
    var cups = cups
    var currentI = 0
    for _ in 0..<moves {
        var destination = cups[currentI % cups.count] - 1

        var pickedUpCups: [Int] = []
        var pickUpI = currentI + 1
        for _ in 0..<3 {
            if pickUpI < cups.count {
                pickedUpCups.append(cups.remove(at: pickUpI))
            } else {
                pickUpI = 0
                pickedUpCups.append(cups.remove(at: 0))
            }
        }

        let next: Int
        if pickUpI < cups.count {
            next = cups[pickUpI]
        } else {
            next = cups[0]
        }
        while pickedUpCups.contains(destination) && destination > 0 {
            destination -= 1
        }
        if destination == 0 {
            destination = cups.max()!
        }
        let destinationI = (cups.firstIndex(of: destination)! + 1) % cups.count
        cups.insert(contentsOf: pickedUpCups, at: destinationI)
        currentI = cups.firstIndex(of: next)!
    }

    let startIndex = cups.firstIndex(of: 1)! + 1
    if startIndex + afterOne < cups.count {
        return Array(cups[startIndex..<startIndex + afterOne])
    } else {
        return Array(cups[startIndex..<cups.count])
             + Array(cups[0..<((startIndex + afterOne) % cups.count)])
    }
}

let answer1 = play(cups: cups, moves: 100, afterOne: cups.count - 1)
    .map { String($0) }
    .joined()

print("Answer 1: \(answer1)")

let millionCups = cups + Array((cups.max()! + 1)...1_000_000)

let result2 = play(cups: millionCups, moves: 10_000_000, afterOne: 2)
let answer2 = result2[0] * result2[1]
print("Answer 2: \(answer2)")
