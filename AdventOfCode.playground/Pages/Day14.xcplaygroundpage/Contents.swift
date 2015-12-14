import Foundation

let path = NSBundle.mainBundle().pathForResource("input", ofType: "txt")!
let input = try! String(contentsOfFile: path).componentsSeparatedByString("\n")

func distancesAfter(seconds:Int, reindeers: [(Int,Int,Int)]) -> [Int] {
    return reindeers.map { r -> Int in
        let speed = r.0
        let flyDuration = r.1
        let restDuration = r.2
        let cycleDuration = flyDuration + restDuration
        let cycles = seconds / cycleDuration
        let rest = seconds - cycles * cycleDuration
        return speed * (cycles * flyDuration + min(rest, flyDuration))
    }
}

let reindeers = input.map { l -> (Int,Int,Int) in
    let words = l.componentsSeparatedByString(" ")
    let speed = Int(words[3])!
    let flyDuration = Int(words[6])!
    let restDuration = Int(words[13])!
    return (speed,flyDuration,restDuration)
}

let task1 = distancesAfter(2503, reindeers: reindeers).maxElement()!
print("Task1: \(task1)")

var points = Array(count: reindeers.count, repeatedValue: 0)
for second in 1...2503 {
    let distances = distancesAfter(second, reindeers: reindeers)
    let maxDistance = distances.maxElement()
    for (i,distance) in distances.enumerate() {
        if distance == maxDistance {
            points[i] += 1
        }
    }
}
print("Task2: \(points.maxElement()!)")
