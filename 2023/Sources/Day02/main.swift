struct GameSet {
    let red: Int
    let green: Int
    let blue: Int

    var isPossible: Bool {
        red <= 12 && green <= 13 && blue <= 14
    }
}

struct Game {
    let id: Int
    let sets: [GameSet]

    var isPossible: Bool {
        sets.allSatisfy(\.isPossible)
    }

    var power: Int {
        var maxRed = 0
        var maxGreen = 0
        var maxBlue = 0
        for set in sets {
            maxRed = max(maxRed, set.red)
            maxGreen = max(maxGreen, set.green)
            maxBlue = max(maxBlue, set.blue)
        }
        return maxRed * maxGreen * maxBlue
    }
}

let games: [Game] = input.split(whereSeparator: \.isNewline).map { line in
    let words = line.split(separator: ":")
    let id = Int(words[0].split(separator: " ")[1])!
    let sets = words[1].split(separator: ";").map {
        var red = 0
        var green = 0
        var blue = 0
        $0.split(separator: ",").forEach {
            let words = $0.split(separator: " ")
            let number = Int(words[0])!
            switch words[1] {
            case "red":
                red = number
            case "green":
                green = number
            case "blue":
                blue = number
            default:
                fatalError()
            }
        }
        return GameSet(red: red, green: green, blue: blue)
    }
    return Game(id: id, sets: sets)
}

let firstAnswer = games.reduce(into: 0) { sum, game in
    if game.isPossible {
        sum += game.id
    }
}
print("Answer 1:", firstAnswer)

let secondAnswer = games.reduce(into: 0) { $0 += $1.power }
print("Answer 2:", secondAnswer)
