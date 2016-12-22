import Foundation

let path = #file.components(separatedBy: "/Sources/main.swift").first! + "/Input/input.txt"
let nodeDescriptions: [String] = try String(contentsOfFile: path)
    .components(separatedBy: .newlines)
    .filter { $0.hasPrefix("/dev/") }

struct Node {
    var used: Int
    var avail: Int

    init(description: String) {
        let components = description.components(separatedBy: .whitespaces).filter { $0 != "" }
        var component = components[2]
        component.remove(at: component.index(before: component.endIndex))
        used = Int(component)!
        component = components[3]
        component.remove(at: component.index(before: component.endIndex))
        avail = Int(component)!
    }
}

let nodes = nodeDescriptions.map { Node(description: $0) }

var viablePairs = 0
for i in 0..<nodes.count {
    for j in 0..<nodes.count {
        if i != j && nodes[i].used > 0 && nodes[i].used <= nodes[j].avail {
            viablePairs += 1
        }
    }
}

print("Task1: \(viablePairs)") // 981

// Task 2: Print and count -> 233
for y in 0..<29 {
    for x in 0..<35 {
        let node = nodes[x * 29 + y]
        if node.used > 100 {
            print("#", terminator: "")
        } else if node.used == 0 {
            print("_", terminator: "")
        } else {
            print(".", terminator: "")
        }
    }
    print("")
}
