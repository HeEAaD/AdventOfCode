let redTiles = input.split(whereSeparator: \.isNewline).map {
    let parts = $0.split(separator: ",")
    return (x: Int(parts[0])!, y: Int(parts[1])!)
}

var largestArea = 0
for i in 0..<redTiles.count - 1 {
    for j in i + 1..<redTiles.count {
        let tileA = redTiles[i]
        let tileB = redTiles[j]
        let area = (abs(tileA.0 - tileB.0) + 1) * (abs(tileA.1 - tileB.1) + 1)
        if area > largestArea {
            largestArea = area
        }
    }
}

print("Answer 1:", largestArea)
