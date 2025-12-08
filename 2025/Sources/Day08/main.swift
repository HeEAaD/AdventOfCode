struct Box: Hashable {
    let x: Int
    let y: Int
    let z: Int
}

func distance(_ a: Box, _ b: Box) -> Double {
    let dx = Double(a.x - b.x)
    let dy = Double(a.y - b.y)
    let dz = Double(a.z - b.z)
    return dx * dx + dy * dy + dz * dz
}

let boxes = input.split(whereSeparator: \.isNewline).map {
    let parts = $0.split(separator: ",")
    return Box(x: Int(parts[0])!, y: Int(parts[1])!, z: Int(parts[2])!)
}

var distances: [(Box, Box, distance: Double)] = []
for i in 0..<boxes.count - 1 {
    for j in (i + 1)..<boxes.count {
        let dist = distance(boxes[i], boxes[j])
        distances.append((boxes[i], boxes[j], dist))
    }
}
distances.sort { $0.distance > $1.distance }

var circuits: [Set<Box>] = []

for connections in 0..<distances.count {
    if connections == 1000 {
        circuits.sort(by: { $0.count > $1.count })
        print("Answer 1:", circuits[0..<3].reduce(into: 1, { $0 *= $1.count }))
    }

    let (box0, box1, _) = distances.removeLast()
    let foundCircuitIndex0 = circuits.firstIndex(where: { $0.contains(box0) })
    let foundCircuitIndex1 = circuits.firstIndex(where: { $0.contains(box1) })

    if foundCircuitIndex0 == nil, foundCircuitIndex1 == nil {
        circuits.append([box0, box1])
        continue
    }

    if foundCircuitIndex0 == foundCircuitIndex1 {
        continue
    }

    if let foundCircuitIndex0, let foundCircuitIndex1 {
        circuits[foundCircuitIndex0].formUnion(circuits[foundCircuitIndex1])
        circuits.remove(at: foundCircuitIndex1)
    } else if let foundCircuitIndex0 {
        circuits[foundCircuitIndex0].insert(box1)
    } else if let foundCircuitIndex1 {
        circuits[foundCircuitIndex1].insert(box0)
    }

    if circuits.count == 1, boxes.count == circuits[0].count {
        print("Answer 2:", box0.x * box1.x)
        break
    }
}
