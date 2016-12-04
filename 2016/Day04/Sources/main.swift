import Foundation

let path = #file.components(separatedBy: "/Sources/main.swift").first! + "/Input/Input.txt"
let input = try String(contentsOfFile: path)
    .components(separatedBy: .newlines)
    .filter { $0 != "" }

func calcChecksum(_ string: String) -> String {

    var counts = [Character:Int]()

    for character in string.characters {
        if let count = counts[character] {
            counts[character] = count + 1
        } else {
            counts[character] = 1
        }
    }

    let chars = counts
        .sorted { l, r in
            if l.value != r.value {
                return l.value > r.value
            }
            return l.key < r.key
        }
        .map { $0.key }

    return String(chars[0..<5])
}

func isReal(line: String) -> Bool {
    let components = line.components(separatedBy: "-")
    let letters = components.dropLast().joined()
    let checksum = String(components.last!.components(separatedBy: "[").last!.characters.dropLast())
    return checksum == calcChecksum(letters)
}

func sectorID(line: String) -> Int {
    let components = line.components(separatedBy: "-")
    return Int(components.last!.components(separatedBy: "[").first!)!
}

func shift(scalar: UnicodeScalar, cyper: UInt32) -> UnicodeScalar {

    let a: UnicodeScalar = "a"
    let z: UnicodeScalar = "z"

    if scalar.value + cyper <= z.value {
        return UnicodeScalar(scalar.value + cyper)!
    } else {
        return UnicodeScalar(a.value + (scalar.value + cyper - 1) % z.value)!
    }
}

func shift(string: String, cyper: UInt32) -> String {
    return String(string.unicodeScalars.map { Character(shift(scalar: $0, cyper: cyper)) })
}

func roomName(line: String) -> String {
    let components = line.components(separatedBy: "-").dropLast()
    let cyper = UInt32(sectorID(line: line)) % 26
    return components.map { shift(string: $0, cyper: cyper) }.joined(separator: " ")
}

let realRooms = input.filter { isReal(line: $0) }

let task1 = realRooms.reduce(0) { sum, line in
    return sum + sectorID(line: line)
}

print("Task 1: \(task1)") // 185371

let task2 = realRooms
    .filter { roomName(line: $0).contains("north") }
    .map { sectorID(line: $0) }

print("Task 2: \(task2)") // 984
