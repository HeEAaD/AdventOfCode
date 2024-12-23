let connections: [(String, String)] = input
    .split(whereSeparator: \.isNewline)
    .map { inputLine in
        let parts = inputLine.split(separator: "-")
        return (String(parts[0]), String(parts[1]))
    }

var connectionsLookup: [String: Set<String>] = [:]
for connection in connections {
    connectionsLookup[connection.0, default: []].insert(connection.1)
    connectionsLookup[connection.1, default: []].insert(connection.0)
}

var threeRings: Set<Set<String>> = []
for (from, toSet) in connectionsLookup {
    for to in toSet {
        connectionsLookup.filter { key, value in
            value.contains(from) && value.contains(to)
        }.forEach { ringCloser in
            threeRings.insert([from, to, ringCloser.key])
        }
    }
}

let withTRings = threeRings.filter { ring in
    ring.contains(where: { $0.hasPrefix("t") })
}
print("Answer 1:", withTRings.count)

var clusters: Set<Set<String>> = threeRings

while true {
    var newClusters: Set<Set<String>> = []
    for connection in connections {
        for cluster in clusters {
            if cluster.contains(connection.0) && !cluster.contains(connection.1) {
                let formsNewCluster = cluster.allSatisfy { e in
                    connectionsLookup[e, default: []].contains(connection.1)
                }
                if formsNewCluster {
                    newClusters.insert(cluster.union([connection.1]))
                }
            }
        }
    }
    if newClusters.isEmpty {
        break
    }
    clusters = newClusters
}

precondition(clusters.count == 1)

print("Answer 2:", clusters.first!.sorted().joined(separator: ","))
