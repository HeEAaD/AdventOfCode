import Foundation

let path = #file.components(separatedBy: "/Sources/main.swift").first! + "/Input/Input.txt"
let input = try String(contentsOfFile: path)
    .components(separatedBy: .newlines)
    .filter { $0 != "" }

protocol Receiver {
    func receive(value: Int)
}

class Output: Receiver {

    var value: Int?

    func receive(value: Int) {
        assert(self.value == nil)
        self.value = value
    }
}

class Bot: Receiver {

    var values = [Int]()
    var lowReceiver: Receiver?
    var heightReceiver: Receiver?

    internal func receive(value: Int) {
        assert(values.count < 2)
        values.append(value)
        if values.count == 2 {
            values.sort()
            lowReceiver?.receive(value: values[0])
            heightReceiver?.receive(value: values[1])
        }
    }
}

var bots = [String:Bot]()
var outputs = [String:Output]()

func getBot(_ key: String) -> Bot {
    let bot = bots[key] ?? Bot()
    bots[key] = bot
    return bot
}

func getOutput(_ key: String) -> Output {
    let output = outputs[key] ?? Output()
    outputs[key] = output
    return output
}

// build the tree
for line in input where line.hasPrefix("bot") {

    let components = line.components(separatedBy: " ")
    assert(components.count == 12)

    let bot = getBot(components[1])

    switch components[5] {
    case "bot":
        bot.lowReceiver = getBot(components[6])
    case "output":
        bot.lowReceiver = getOutput(components[6])
    default:
        assertionFailure()
    }

    switch components[10] {
    case "bot":
        bot.heightReceiver = getBot(components[11])
    case "output":
        bot.heightReceiver = getOutput(components[11])
    default:
        assertionFailure()
    }
}

// fill the tree
for line in input where line.hasPrefix("value") {
    let components = line.components(separatedBy: " ")
    assert(components.count == 6)

    let bot = getBot(components[5])
    bot.receive(value: Int(components[1])!)
}

let task1Bot = bots.first { (key, bot) -> Bool in
    return bot.values.contains(61) && bot.values.contains(17)
}

print("Task1: \(task1Bot!.key)") // 56

var task2 = 1
for i in 0...2 {
    task2 *= outputs[String(i)]!.value!
}
print("Task1: \(task2)") // 7847
