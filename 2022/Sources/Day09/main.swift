struct Coord: Hashable {
    var x: Int
    var y: Int
}

func tailCoordCount(ropeLength: Int, input: String) -> Int {
    var rope = Array(repeating: Coord(x: 0, y: 0), count: ropeLength)
    var tailCoords: Set<Coord> = [rope[rope.count - 1]]
    for line in input.split(whereSeparator: \.isNewline) {
        let components = line.split(separator: " ")
        let steps = Int(components[1])!
        for _ in 0..<steps {
            switch components[0] {
            case "R": rope[0].x += 1
            case "L": rope[0].x -= 1
            case "U": rope[0].y -= 1
            case "D": rope[0].y += 1
            default: fatalError()
            }
            for i in 1..<rope.count {
                if rope[i-1].x - rope[i].x > 1 {
                    rope[i].x += 1
                    if rope[i-1].y < rope[i].y {
                        rope[i].y -= 1
                    } else if rope[i-1].y > rope[i].y {
                        rope[i].y += 1
                    }
                } else if rope[i-1].x - rope[i].x < -1 {
                    rope[i].x -= 1
                    if rope[i-1].y < rope[i].y {
                        rope[i].y -= 1
                    } else if rope[i-1].y > rope[i].y {
                        rope[i].y += 1
                    }
                }
                if rope[i-1].y - rope[i].y > 1 {
                    rope[i].y += 1
                    if rope[i-1].x < rope[i].x {
                        rope[i].x -= 1
                    } else if rope[i-1].x > rope[i].x {
                        rope[i].x += 1
                    }
                } else if rope[i-1].y - rope[i].y < -1 {
                    rope[i].y -= 1
                    if rope[i-1].x < rope[i].x {
                        rope[i].x -= 1
                    } else if rope[i-1].x > rope[i].x {
                        rope[i].x += 1
                    }
                }
            }
            tailCoords.insert(rope[rope.count - 1])
        }
    }
    return tailCoords.count
}

print("Answer 1:", tailCoordCount(ropeLength: 2, input: input))
print("Answer 2:", tailCoordCount(ropeLength: 10, input: input))
