let lines = input
    .split(omittingEmptySubsequences: false, whereSeparator: \.isNewline)

struct Dot: Hashable {
    let x: Int
    let y: Int
}

var dots: Set<Dot> = []

for line in lines {
    guard !line.isEmpty else { break }
    let words = line.split(separator: ",")
    let x = Int(words[0])!
    let y = Int(words[1])!
    dots.insert(Dot(x: x, y: y))
}

for (i, line) in lines.drop(while: {!$0.hasPrefix("fold")}).enumerated() {
    var newDots: Set<Dot> = []
    let words = line.split(separator: " ")[2].split(separator: "=")
    switch words[0] {
    case "x":
        let foldX = Int(words[1])!
        for dot in dots {
            guard dot.x > foldX else {
                newDots.insert(dot)
                continue
            }
            newDots.insert(Dot(x: foldX - (dot.x - foldX), y: dot.y))
        }
    case "y":
        let foldY = Int(words[1])!
        for dot in dots {
            guard dot.y > foldY else {
                newDots.insert(dot)
                continue
            }
            newDots.insert(Dot(x: dot.x, y: foldY - (dot.y - foldY)))
        }
    default:
        fatalError()
    }

    dots = newDots

    if i == 0 {
        print("Answer 1:", dots.count)
    }
}

print("Answer 2:")
// Read code to stdout
for y in 0...dots.map(\.y).max()! {
    var line = ""
    for x in 0...dots.map(\.x).max()! {
        if dots.contains(Dot(x: x, y: y)) {
            line.append("#")
        } else {
            line.append(" ")
        }
    }
    print(line)
}
