import Foundation

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

func knotHash(_ input: String, radix: Int = 16) -> String {
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
        var block = String(sparseHash[i+1..<i+16].reduce(sparseHash[i], ^), radix: radix)
        for _ in 0..<(16 / radix - block.count) {
           block = "0\(block)"
        }
        denseHash += block
    }
    return denseHash
}
