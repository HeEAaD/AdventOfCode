import Foundation

let path = #file.components(separatedBy: "/Sources/main.swift").first! + "/Input/Input.txt"
let input = try String(contentsOfFile: path)
    .components(separatedBy: .newlines)
    .filter { $0 != "" }

extension String {

    var containsABBA: Bool {
        for i in 0..<(self.characters.count - 3) {
            let abba = [
                self[self.index(self.startIndex, offsetBy: i)],
                self[self.index(self.startIndex, offsetBy: i+1)],
                self[self.index(self.startIndex, offsetBy: i+2)],
                self[self.index(self.startIndex, offsetBy: i+3)]
            ]

            if abba[0] == abba[3] && abba[1] == abba[2] && abba[0] != abba[1] {
                return true
            }
        }
        return false
    }

    var supportsTLS: Bool {
        let components = self.components(separatedBy: CharacterSet(charactersIn: "[]"))
        assert(components.count % 2 == 1)

        var foundABBA = false
        for (i, component) in components.enumerated() {
            if i % 2 == 0 {
                if component.containsABBA {
                    foundABBA = true
                }
            } else {
                if component.containsABBA {
                    return false
                }
            }
        }
        return foundABBA
    }

    var supportsSSL: Bool {
        let components = self.components(separatedBy: CharacterSet(charactersIn: "[]"))
        for i in stride(from: 0, to: components.count, by: 2) {

            let component = components[i]

            for j in 0..<(components[i].characters.count - 2) {
                let aba = [
                    component[component.index(component.startIndex, offsetBy: j)],
                    component[component.index(component.startIndex, offsetBy: j + 1)],
                    component[component.index(component.startIndex, offsetBy: j + 2)]
                ]

                if aba[0] == aba[2] && aba[0] != aba[1] {
                    let bab = String([aba[1], aba[0], aba[1]])

                    for i2 in stride(from: 1, to: components.count, by: 2) {
                        if components[i2].contains(bab) {
                            return true
                        }
                    }
                }
            }
        }

        return false
    }
}

let task1 = input.reduce(0) { $1.supportsTLS ? $0 + 1 : $0 }
print("Task 1: \(task1)") // 105 to height

let task2 = input.reduce(0) { $1.supportsSSL ? $0 + 1 : $0 }
print("Task 2: \(task2)") // 258 to height
