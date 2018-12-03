import Foundation

struct Patch {
    let id: Int
    let x: Int
    let y: Int
    let w: Int
    let h: Int
}

let patches = input.split(separator: "\n").compactMap { line -> Patch? in
    let numbers = line.replacingOccurrences(of: ",", with: " ")
        .replacingOccurrences(of: ":", with: "")
        .replacingOccurrences(of: "x", with: " ")
        .replacingOccurrences(of: "#", with: "")
        .split(separator: " ")
        .compactMap { Int($0) }
    guard numbers.count == 5 else { return nil }
    return Patch(id: numbers[0], x: numbers[1], y: numbers[2], w: numbers[3], h: numbers[4])
}

// MARK: Task 1
// O(n)
var grid = Array(repeating: Array(repeating: 0, count: 1000), count: 1000)

for patch in patches {
    for i in patch.x..<patch.x + patch.w {
        for j in patch.y..<patch.y + patch.h {
            grid[i][j] += 1
        }
    }
}

let overlapping = grid.reduce(0) { $0 + $1.reduce(0) { $1 > 1 ? $0 + 1 : $0 } }
print("Task 1: \(overlapping)")

// MARK: Task 2
// O(n)
var nonOverlapping: Int?
for patch in patches {
    var overlapping = false
    for i in patch.x..<patch.x + patch.w {
        for j in patch.y..<patch.y + patch.h {
            if grid[i][j] > 1 {
                overlapping = true
                break
            }
        }
        if overlapping {
            break
        }
    }
    if !overlapping {
        nonOverlapping = patch.id
        break
    }
}

print("Task 2: \(nonOverlapping!)")
