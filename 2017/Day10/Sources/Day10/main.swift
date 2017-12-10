import Foundation

let input = "63,144,180,149,1,255,167,84,125,65,188,0,2,254,229,24"

func createList() -> [Int] {
    return (0..<256).reduce([Int]()) { list, i in
        var list = list
        list.append(i)
        return list
    }
}

extension Array {
    mutating func reverse(from: Array.Index, length: Array.Index) {
        var from = from
        for l in stride(from: length, to: 0, by: -2) {
            let i = from % self.count
            let j = (from + l - 1) % self.count
            self.swapAt(i, j)
            from = (from + 1) % self.count
        }
    }
}

func task1(_ input: String) -> Int {
    var list = createList()
    var position = 0
    var skip = 0

    let lengths = input.split(separator: ",").map { Int($0)! }

    for length in lengths {
        list.reverse(from: position, length: length)
        position = (position + length + skip) % list.count
        skip += 1
    }

    return list[0] * list[1]
}

func task2(_ input: String) -> String {
    var sparseHash = createList()
    var position = 0
    var skip = 0

    var lengths = input.unicodeScalars.map { Int($0.value) }
    lengths.append(contentsOf: [17, 31, 73, 47, 23])

    for _ in 0..<64 {
        for length in lengths {
            sparseHash.reverse(from: position, length: length)
            position = (position + length + skip) % sparseHash.count
            skip += 1
        }
    }

    var denseHash = ""
    for i in stride(from: 0, to: sparseHash.count, by: 16) {
        denseHash += String(format: "%02x", sparseHash[i+1..<i+16].reduce(sparseHash[i], ^))
    }
    return denseHash
}

print("Task1: \(task1(input))")
print("Task2: \(task2(input))")
