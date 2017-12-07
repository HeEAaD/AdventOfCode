import Foundation

let path = ((#file as NSString).deletingLastPathComponent as NSString).appendingPathComponent("input.txt")
let input = try String(contentsOfFile: path)
    .components(separatedBy: .newlines)
    .filter { $0 != "" }

struct Node {
    let name: String
    let weight: Int
    var children: [Node]?
    let childrenNames: [String]
    var commulatedWeight: Int?

    init(string: String) {
        let regex = try! NSRegularExpression(pattern: "^([a-z]+) \\(([0-9]+)\\)( -> ([a-z, ]+))?", options: [])
        let matches = regex.matches(in: string, range: NSRange(location: 0, length: string.count))
        name = (string as NSString).substring(with: matches[0].range(at: 1))
        weight = Int((string as NSString).substring(with: matches[0].range(at: 2)))!
        let childrenRange = matches[0].range(at: 4)
        if childrenRange.location != NSNotFound {
            childrenNames = (string as NSString).substring(with: childrenRange).split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        } else {
            childrenNames = []
        }
    }
}

let nodes = input.map(Node.init)

func getRoot(_ nodes: [Node]) -> Node {
    for node in nodes where !node.childrenNames.isEmpty {
        var isRoot = true
        for node2 in nodes {
            if node2.childrenNames.contains(node.name) {
                isRoot = false
                break
            }
        }

        if isRoot {
            return node
        }
    }
    fatalError()
}

func buildTree(nodes: [Node], root: Node) -> Node {
    var root = root
    root.children = root.childrenNames.map { childName -> Node in
        let child = nodes.first { $0.name == childName }!
        return buildTree(nodes: nodes, root: child)
    }

    let childrenWeights = (root.children ?? []).map { $0.commulatedWeight! }
    if Set(childrenWeights).count > 1 {
        print("Task 2: BREAKPOINT HERE!")
    }
    root.commulatedWeight = root.weight + childrenWeights.reduce(0, +)
    return root
}

let root = getRoot(nodes)
print("Task 1: \(root.name)")

_ = buildTree(nodes: nodes, root: root)
