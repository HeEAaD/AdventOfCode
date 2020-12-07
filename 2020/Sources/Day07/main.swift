let lines = input.split(whereSeparator: \.isNewline)

let bags: [String: [(Int, String)]] = lines.reduce(into: [:]) { bags, line in
    let words = line.split(separator: " ")
    let color = words[0...1].joined(separator: " ")
    var contents: [(Int, String)] = []
    if words[4] != "no" {
        for i in stride(from: 4, to: words.count, by: 4) {
            contents.append((Int(words[i])!, words[i+1...i+2].joined(separator: " ")))
        }
    }
    bags[color] = contents
}

var containers: Set<String> = ["shiny gold"]
var countBefore = 0
repeat {
    countBefore = containers.count
    for container in containers {
        for bag in bags {
            if bag.value.contains(where: { $0.1 == container }) {
                containers.insert(bag.key)
            }
        }
    }
} while containers.count > countBefore

print("Answer 1: \(containers.count - 1)")

func countBags(bag: String) -> Int {
    bags[bag]!.reduce(into: 1) { sum, bag in
        sum += bag.0 * countBags(bag: bag.1)
    }
}

print("Answer 2: \(countBags(bag: "shiny gold") - 1)")
