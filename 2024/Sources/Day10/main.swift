struct Point: Hashable {
    let x: Int
    let y: Int
}

let map: [[UInt8]] = input
    .split(whereSeparator: \.isNewline)
    .map { $0.map { UInt8(String($0))! } }

var trailheads: [Point] = []
for y in map.indices {
    for x in map[y].indices {
        if map[y][x] == 0 {
            trailheads.append(Point(x: x, y: y))
        }
    }
}

var scoresSum: Int = 0
var trailsSum: Int = 0
for trailhead in trailheads {
    scoresSum += reachablePeaks(from: trailhead).count
    trailsSum += trails(from: [trailhead]).count
}

print("Answer 1:", scoresSum)
print("Answer 2:", trailsSum)

func reachablePeaks(from head: Point) -> Set<Point> {
    let height = map[head.y][head.x]
    guard height < 9 else {
        return [head]
    }
    var result: Set<Point> = []
    if head.x > 0, map[head.y][head.x - 1] == height + 1 {
        result.formUnion(reachablePeaks(from: Point(x: head.x - 1, y: head.y)))
    }
    if head.x < map[head.y].count - 1, map[head.y][head.x + 1] == height + 1 {
        result.formUnion(reachablePeaks(from: Point(x: head.x + 1, y: head.y)))
    }
    if head.y > 0, map[head.y - 1][head.x] == height + 1 {
        result.formUnion(reachablePeaks(from: Point(x: head.x, y: head.y - 1)))
    }
    if head.y < map.count - 1, map[head.y + 1][head.x] == height + 1 {
        result.formUnion(reachablePeaks(from: Point(x: head.x, y: head.y + 1)))
    }

    return result
}

func trails(from trail: [Point]) -> Set<[Point]> {
    let lastStep = trail.last!
    let height = map[lastStep.y][lastStep.x]
    guard height < 9 else {
        return [trail]
    }
    var result: Set<[Point]> = []
    if lastStep.x > 0, map[lastStep.y][lastStep.x - 1] == height + 1 {
        result.formUnion(trails(from: trail + [Point(x: lastStep.x - 1, y: lastStep.y)]))
    }
    if lastStep.x < map[lastStep.y].count - 1, map[lastStep.y][lastStep.x + 1] == height + 1 {
        result.formUnion(trails(from: trail + [Point(x: lastStep.x + 1, y: lastStep.y)]))
    }
    if lastStep.y > 0, map[lastStep.y - 1][lastStep.x] == height + 1 {
        result.formUnion(trails(from: trail + [Point(x: lastStep.x, y: lastStep.y - 1)]))
    }
    if lastStep.y < map.count - 1, map[lastStep.y + 1][lastStep.x] == height + 1 {
        result.formUnion(trails(from: trail + [Point(x: lastStep.x, y: lastStep.y + 1)]))
    }
    return result
}
