let connections = input
    .split(whereSeparator: \.isNewline)
    .reduce(into: [(String, String)](), { connections, line in
        let caves = line.split(separator: "-")
        if caves[1] != "start" && caves[0] != "end" {
            connections.append((String(caves[0]), String(caves[1])))
        }
        if caves[0] != "start" && caves[1] != "end" {
            connections.append((String(caves[1]), String(caves[0])))
        }
    })

enum Task {
    case first
    case second
}

func run(task: Task, connections: [(String, String)]) -> Int {
    var pathsCounts: [(lastCave: String, smallCounts: [String: Int])] = connections
        .filter { $0.0 == "start" }
        .map { ($0.1, $0.1.first!.isLowercase ? [$0.1: 1] : [:]) }
    while true {
        var newPathsCounts: [(lastCave: String, smallCounts: [String: Int])] = []
        var pathAdded = false
        for (lastCave, smallCounts) in pathsCounts {
            guard lastCave != "end" else {
                newPathsCounts.append((lastCave, smallCounts))
                continue
            }

            for connection in connections where connection.0 == lastCave {
                if connection.1.first!.isLowercase {
                    switch task {
                    case .first:
                        guard smallCounts[connection.1] == nil else { continue }
                    case .second:
                        let count = smallCounts[connection.1, default: 0]
                        if count > 1 || (count == 1 && smallCounts.values.contains(where: { $0 > 1 })) {
                            continue
                        }
                    }
                }
                var smallCounts = smallCounts
                if connection.1.first!.isLowercase {
                    smallCounts[connection.1, default: 0] += 1
                }
                newPathsCounts.append((connection.1, smallCounts))
                pathAdded = true
            }
        }
        pathsCounts = newPathsCounts
        if !pathAdded {
            return pathsCounts.count
        }
    }
}

print("Answer 1:", run(task: .first, connections: connections))
print("Answer 2:", run(task: .second, connections: connections))
