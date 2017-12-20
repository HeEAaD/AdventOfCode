import Foundation

let path = ((#file as NSString).deletingLastPathComponent as NSString).appendingPathComponent("input.txt")
let input = try String(contentsOfFile: path)
    .trimmingCharacters(in: .whitespacesAndNewlines)
    .components(separatedBy: .newlines)

let regex = try! NSRegularExpression(pattern: "p=<(.*),(.*),(.*)>, v=<(.*),(.*),(.*)>, a=<(.*),(.*),(.*)>", options: [])

class Particle {

    var p: (x: Int, y: Int, z: Int)
    var v: (x: Int, y: Int, z: Int)
    let a: (x: Int, y: Int, z: Int)

    init(string: String) {
        let matches = regex.matches(in: string, range: NSRange(location: 0, length: string.count))
        let nsString = string as NSString
        p = (
            x: Int(nsString.substring(with: matches[0].range(at: 1)))!,
            y: Int(nsString.substring(with: matches[0].range(at: 2)))!,
            z: Int(nsString.substring(with: matches[0].range(at: 3)))!
        )
        v = (
            x: Int(nsString.substring(with: matches[0].range(at: 4)))!,
            y: Int(nsString.substring(with: matches[0].range(at: 5)))!,
            z: Int(nsString.substring(with: matches[0].range(at: 6)))!
        )
        a = (
            x: Int(nsString.substring(with: matches[0].range(at: 7)))!,
            y: Int(nsString.substring(with: matches[0].range(at: 8)))!,
            z: Int(nsString.substring(with: matches[0].range(at: 9)))!
        )
    }

    func move(steps: Int = 1) {
        v.x += a.x * steps
        v.y += a.y * steps
        v.z += a.z * steps

        p.x += v.x
        p.y += v.y
        p.z += v.z
    }

    var distance: Int {
        return abs(p.x) + abs(p.y) + abs(p.z)
    }
}

extension Particle: Hashable {
    var hashValue: Int {
        return "\(p.x),\(p.y),\(p.z)".hashValue
    }

    static func ==(lhs: Particle, rhs: Particle) -> Bool {
        return lhs.p == rhs.p
    }
}

func task1() {
    let particles = input.map(Particle.init)

    var min = (i: -1, distance: Int.max)

    for (i, particle) in particles.enumerated() {
        particle.move(steps: 1_000_000_000) // "long run"
        let distance = particle.distance
        if distance < min.distance {
            min = (i: i, distance: distance)
        }
    }

    print("Task1: \(min.i)")
}

func task2() {
    var particles = input.map(Particle.init)

    for _ in 0..<100 {
        var count = [Particle: Int]()
        for particle in particles {
            particle.move()
            count[particle] = (count[particle] ?? 0) + 1
        }

        particles = Array(count.filter({ $0.value == 1 }).keys)
    }

    print("Task2: \(particles.count)")
}

task1()
task2()
