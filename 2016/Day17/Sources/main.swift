import Foundation
import CryptoSwift

extension Character {
    var isOpen: Bool {
        return "b"..."f" ~= self
    }
}

struct State {
    let path: String
    let x: Int
    let y: Int

    func nextStates(passcode: String) -> [State] {
        var nextStates = [State]()
        let md5 = passcode.appending(path).md5()
        if y > 0 && md5[md5.startIndex].isOpen {
            nextStates.append(State(path: self.path + "U", x: self.x, y: self.y - 1))
        }
        if y < 3 && md5[md5.index(md5.startIndex, offsetBy: 1)].isOpen {
            nextStates.append(State(path: self.path + "D", x: self.x, y: self.y + 1))
        }
        if x > 0 && md5[md5.index(md5.startIndex, offsetBy: 2)].isOpen {
            nextStates.append(State(path: self.path + "L", x: self.x - 1, y: self.y))
        }
        if x < 3 && md5[md5.index(md5.startIndex, offsetBy: 3)].isOpen {
            nextStates.append(State(path: self.path + "R", x: self.x + 1, y: self.y))
        }
        return nextStates
    }
}

/// - Returns: Shorted path
func task1(passcode: String) -> String? {

    var queue = [State(path: "", x: 0, y: 0)]

    while !queue.isEmpty {
        let s = queue.removeFirst()
        if s.x == 3 && s.y == 3 {
            return s.path
        }

        let nextStates = s.nextStates(passcode: passcode)
        queue.append(contentsOf: nextStates)
    }

    return nil
}

/// - Note: This is a brute force algorithm. There should be a better solution.
/// - Returns: Longest path length
func task2(passcode: String) -> Int {

    var longestPathLength = -1
    var queue = [State(path: "", x: 0, y: 0)]

    while !queue.isEmpty {
        let s = queue.removeFirst()
        if s.x == 3 && s.y == 3 {
            let pathLength = s.path.characters.count
            if pathLength > longestPathLength {
                longestPathLength = pathLength
            }
            continue
        }

        let nextStates = s.nextStates(passcode: passcode)
        queue.append(contentsOf: nextStates)
    }

    return longestPathLength
}

let result1 = task1(passcode: "pslxynzg") ?? "NOT FOUND"
print("Task1: \(result1)")

let result2 = task2(passcode: "pslxynzg")
print("Task2: \(result2)")
