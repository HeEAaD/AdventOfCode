var orbits: [String:String] = [:]

for line in input.split(separator: "\n") {
    let splittedLine = line.split(separator: ")")
    orbits[String(splittedLine[1])] = String(splittedLine[0])
}

func indirectOrbits(around center: String, depth: Int) -> Int {
    let orbitsAroundCenter = orbits.filter({ $0.value == center }).keys
    return depth * orbitsAroundCenter.count + orbitsAroundCenter.reduce(0, { $0 + indirectOrbits(around: $1, depth: depth + 1)})
}

print("Part 1: \(indirectOrbits(around: "COM", depth: 1))")

func pathToCOM(orbit: String) -> [String] {
    let center = orbits[orbit]!
    if center == "COM" {
        return [center]
    }
    return [center] + pathToCOM(orbit: center)
}

let comToSan = pathToCOM(orbit: "SAN").reversed()
let comToYou = pathToCOM(orbit: "YOU").reversed()

var commonPathCount = 0
for (a, b) in zip(comToSan, comToYou) {
    if a != b { break }
    commonPathCount += 1
}

print("Part 2: \(comToYou.count - commonPathCount + comToSan.count - commonPathCount)")
