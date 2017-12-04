import Foundation

let path = ((#file as NSString).deletingLastPathComponent as NSString).appendingPathComponent("input.txt")
let input = try String(contentsOfFile: path)
    .components(separatedBy: .newlines)
    .filter { $0 != "" }
    .map { $0.components(separatedBy: .whitespaces) }

let task1 = input.reduce(0) { sum, passphrase in
    return Set(passphrase).count == passphrase.count ? sum + 1 : sum
}

print("Task 1: \(task1)")

let task2 = input.reduce(0) { sum, passphrase in
    let sorted: [String] = passphrase.map { String($0.sorted()) }
    return Set(sorted).count == sorted.count ? sum + 1 : sum
}

print("Task 2: \(task2)")
