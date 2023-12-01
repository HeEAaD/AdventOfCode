let lines = input.split(whereSeparator: \.isNewline)

var sum = 0
for line in lines {
    let first = Int(String(line.first(where: \.isNumber)!))!
    let last = Int(String(line.last(where: \.isNumber)!))!
    sum += first * 10 + last
}
print("Answer 1:", sum)

func firstNumber(in string: any StringProtocol) -> Int {
    var substring = ""
    for char in string {
        if char.isNumber {
            return Int(String(char))!
        }
        substring += String(char)
        if substring.hasSuffix("one") {
            return 1
        } else if substring.hasSuffix("two") {
            return 2
        } else if substring.hasSuffix("three") {
            return 3
        } else if substring.hasSuffix("four") {
            return 4
        } else if substring.hasSuffix("five") {
            return 5
        } else if substring.hasSuffix("six") {
            return 6
        } else if substring.hasSuffix("seven") {
            return 7
        } else if substring.hasSuffix("eight") {
            return 8
        } else if substring.hasSuffix("nine") {
            return 9
        }
    }
    fatalError()
}

func lastNumber(in string: any StringProtocol) -> Int {
    var substring = ""
    for char in string.reversed() {
        if char.isNumber {
            return Int(String(char))!
        }
        substring += String(char)
        if substring.hasSuffix("eno") {
            return 1
        } else if substring.hasSuffix("owt") {
            return 2
        } else if substring.hasSuffix("eerht") {
            return 3
        } else if substring.hasSuffix("ruof") {
            return 4
        } else if substring.hasSuffix("evif") {
            return 5
        } else if substring.hasSuffix("xis") {
            return 6
        } else if substring.hasSuffix("neves") {
            return 7
        } else if substring.hasSuffix("thgie") {
            return 8
        } else if substring.hasSuffix("enin") {
            return 9
        }
    }
    fatalError()
}

sum = 0
for line in lines {
    sum += firstNumber(in: line) * 10 + lastNumber(in: line)
}
print("Answer 2:", sum)
