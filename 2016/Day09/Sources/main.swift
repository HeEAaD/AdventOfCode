import Foundation

let path = #file.components(separatedBy: "/Sources/main.swift").first! + "/Input/Input.txt"
let input = try String(contentsOfFile: path).trimmingCharacters(in: .whitespacesAndNewlines)

enum Task {
    case one
    case two
}

func parseMarker(string: String) -> (length: Int, times: Int) {
    let comp = string.components(separatedBy: "x")
    assert(comp.count == 2)
    return (Int(comp[0])!, Int(comp[1])!)
}

func decompressedLength(string: String, task: Task = .one) -> Int {

    var result = 0

    var i = string.startIndex
    var markerStart: String.Index?

    repeat {
        if string[i] == "(" {
            markerStart = i
        } else if let markerStartUnpacked = markerStart {

            if string[i] == ")" {
                markerStart = nil

                let marker = string[string.index(after: markerStartUnpacked)..<i]
                let (length, times) = parseMarker(string: marker)

                switch task {
                case .one:
                    result += length * times
                case .two:
                    let s = string[string.index(after: i)...string.index(i, offsetBy: length)]
                    result += decompressedLength(string: s, task: task) * times
                }

                i = string.index(i, offsetBy: length)
            }
        } else {
            result += 1
        }

        i = string.index(after: i)

    } while i<string.endIndex

    return result
}

assert(decompressedLength(string: "ADVENT") == 6)
assert(decompressedLength(string: "A(1x5)BC") == 7)
assert(decompressedLength(string: "(3x3)XYZ") == 9)
assert(decompressedLength(string: "A(2x2)BCD(2x2)EFG") == 11)
assert(decompressedLength(string: "(6x1)(1x3)A") == 6)
assert(decompressedLength(string: "X(8x2)(3x3)ABCY") == 18)

let task1 = decompressedLength(string: input)
print("Task1 \(task1)") // 152851

assert(decompressedLength(string: "(27x12)(20x12)(13x14)(7x10)(1x12)A", task: .two) == 241920)

let task2 = decompressedLength(string: input, task: .two)
print("Task2 \(task2)") // 11797310782
