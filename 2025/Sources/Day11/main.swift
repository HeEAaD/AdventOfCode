func allPathsCount(
    _ connections: [String: [String]],
    from start: String,
    to end: String
) -> UInt64 {
    var pathEndCounts: [String: UInt64] = [start: 1]
    var result: UInt64 = 0
    var pathAdded = true
    repeat {
        pathAdded = false
        var newPathEndCounts: [String: UInt64] = [:]
        for (pathEnd, count) in pathEndCounts {
            guard let conns = connections[pathEnd] else {
                continue
            }
            for conn in conns {
                if conn == end {
                    result += count
                } else {
                    newPathEndCounts[conn, default: 0] += count
                    pathAdded = true
                }
            }
        }
        pathEndCounts = newPathEndCounts
    } while pathAdded

    return result
}

let connections = input
    .split(whereSeparator: \.isNewline)
    .reduce(into: [:] as [String: [String]]) { partialResult, line in
        let parts = line.split(separator: " ")
        let name = String(parts[0].dropLast())
        let conns = parts.dropFirst().map { String($0) }
        partialResult[name] = conns
    }

print("Answer 1:", allPathsCount(connections, from: "you", to: "out"))
let dacOutCount = allPathsCount(connections, from: "dac", to: "out")
let fftDacCount = allPathsCount(connections, from: "fft", to: "dac")
let svrFftCount = allPathsCount(connections, from: "svr", to: "fft")
print("Answer 2:", svrFftCount * fftDacCount * dacOutCount)
