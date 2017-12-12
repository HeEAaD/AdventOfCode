import Foundation

let path = ((#file as NSString).deletingLastPathComponent as NSString).appendingPathComponent("input.txt")
let input = try String(contentsOfFile: path)
    .split(separator: "\n")
    .filter { !$0.isEmpty }
    .map { $0
        .replacingOccurrences(of: ",", with: "")
        .replacingOccurrences(of: "<", with: "")
        .replacingOccurrences(of: "-", with: "")
        .replacingOccurrences(of: ">", with: "")
        .split(separator: " ").map { Int(String($0))! } }
    .reduce([Int: [Int]](), { edges, nodes in
        var edges = edges
        edges[nodes[0]] = Array(nodes[1...])
        return edges
    })

func findGroup(in edges: [Int: [Int]], seed: Int) -> Set<Int> {
    var group: Set<Int> = [seed]
    var lookupNodes: Set<Int> = [seed]

    while !lookupNodes.isEmpty {
        var nextLookupNodes: Set<Int> = []
        for node in lookupNodes {
            edges[node]?.forEach { node in
                if group.insert(node).inserted {
                    nextLookupNodes.insert(node)
                }
            }
        }
        lookupNodes = nextLookupNodes
    }

    return group
}

func task1(_ edges: [Int: [Int]]) -> Int {
    return findGroup(in: edges, seed: 0).count
}

func task2(_ edges: [Int: [Int]]) -> Int {
    var edges = edges
    var groupsCount = 0
    while !edges.isEmpty {
        let group = findGroup(in: edges, seed: edges.keys.first!)
        for node in group {
            edges[node] = nil
        }
        groupsCount += 1
    }
    return groupsCount
}

print("Task1: \(task1(input))")
print("Task2: \(task2(input))")
