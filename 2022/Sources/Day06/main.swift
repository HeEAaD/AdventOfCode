let chars = input.map { $0 }

func endOfMarkerNaive(length: Int) -> Int {
    for i in 0 ..< chars.count - length where Set(chars[i ..< i + length]).count == length {
        return i + length
    }
    fatalError()
}

print("Answer 1:", endOfMarkerNaive(length: 4))
print("Answer 2:", endOfMarkerNaive(length: 14))
