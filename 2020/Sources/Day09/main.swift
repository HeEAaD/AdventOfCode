//let data = sampleInput.split(whereSeparator: \.isNewline).map { Int($0)! }
//let preamble = 5
let data = input.split(whereSeparator: \.isNewline).map { Int($0)! }
let preamble = 25

var invalidN = -1

for i in preamble..<data.count {
    let n = data[i]
    var isValid = false
    for l in i-preamble..<i {
        for k in i-preamble..<i where l != k {
            if data[l] + data[k] == n {
                isValid = true
                break
            }
        }
        if isValid {
            break
        }
    }
    if !isValid {
        invalidN = n
        break
    }
}

print("Answer 1: \(invalidN)")

var weakness = -1

for i in 0..<data.count {
    var sum = data[i]
    for k in i+1..<data.count {
        sum += data[k]
        if sum == invalidN {
            let range = data[i...k]
            weakness = range.min()! + range.max()!
            break
        } else if sum > invalidN {
            break
        }
    }
    if weakness != -1 {
        break
    }
}

print("Answer 2: \(weakness)")
