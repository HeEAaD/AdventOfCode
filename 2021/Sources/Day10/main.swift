let lines = input.split(whereSeparator: \.isNewline)

var syntaxErrorScore = 0
var incompleteScores: [Int] = []

for line in lines {

    var isSyntaxError = false
    var stack: [Character] = []

    for char in line {

        isSyntaxError = false

        switch char {
        case "(", "[", "{", "<":
            stack.append(char)
        case ")":
            if stack.popLast() != "(" {
                syntaxErrorScore += 3
                isSyntaxError = true
            }
        case "]":
            if stack.popLast() != "[" {
                syntaxErrorScore += 57
                isSyntaxError = true
            }
        case "}":
            if stack.popLast() != "{" {
                syntaxErrorScore += 1197
                isSyntaxError = true
            }
        case ">":
            if stack.popLast() != "<" {
                syntaxErrorScore += 25137
                isSyntaxError = true
            }
        default:
            fatalError()
        }

        if isSyntaxError {
            break
        }

    }

    if !isSyntaxError {
        var incompleteScore = 0
        for e in stack.reversed() {
            incompleteScore *= 5
            switch e {
            case "(":
                incompleteScore += 1
            case "[":
                incompleteScore += 2
            case "{":
                incompleteScore += 3
            case "<":
                incompleteScore += 4
            default:
                fatalError()
            }
        }
        incompleteScores.append(incompleteScore)
    }

}

print("Answer 1:", syntaxErrorScore)
print("Answer 2:", incompleteScores.sorted()[incompleteScores.count / 2])
