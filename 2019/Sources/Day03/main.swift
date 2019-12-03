let path0 = input.split(separator: "\n")[0].split(separator: ",").map { String($0) }
let path1 = input.split(separator: "\n")[1].split(separator: ",").map { String($0) }

//let path0 = "R8,U5,L5,D3".split(separator: ",").map { String($0) }
//let path1 = "U7,R6,D4,L4".split(separator: ",").map { String($0) }

//let path0 = "R75,D30,R83,U83,L12,D49,R71,U7,L72".split(separator: ",").map { String($0) }
//let path1 = "U62,R66,U55,R34,D71,R55,D58,R83".split(separator: ",").map { String($0) }

//let path0 = "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51".split(separator: ",").map { String($0) }
//let path1 = "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7".split(separator: ",").map { String($0) }

struct Pos: Hashable { let x: Int, y: Int }

var pos = (0, 0)
var stepCount = 0
var path0Steps: [Pos: Int] = [:]
for step in path0 {
    let steps = Int(step.dropFirst())!
    for _ in 0..<steps {
        switch step.first {
        case "R":
            pos.0 += 1
        case "L":
            pos.0 -= 1
        case "U":
            pos.1 -= 1
        case "D":
            pos.1 += 1
        default:
            fatalError()
        }
        stepCount += 1
        path0Steps[Pos(x: pos.0, y: pos.1)] = stepCount
    }
}

var minDistance = Int.max
var minPathDistance = Int.max
pos = (0, 0)
stepCount = 0
for step in path1 {
    let steps = Int(step.dropFirst())!
    for _ in 0..<steps {
        switch step.first {
        case "R":
            pos.0 += 1
        case "L":
            pos.0 -= 1
        case "U":
            pos.1 -= 1
        case "D":
            pos.1 += 1
        default:
            fatalError()
        }
        stepCount += 1
        if let path0StepCount = path0Steps[Pos(x: pos.0, y: pos.1)] {
            let distance = abs(pos.0) + abs(pos.1)
            if distance < minDistance {
                minDistance = distance
            }
            let pathDistance = path0StepCount + stepCount
            if pathDistance < minPathDistance {
                minPathDistance = pathDistance
            }
        }
    }
}

print("Part 0: \(minDistance)")
print("Part 1: \(minPathDistance)")
