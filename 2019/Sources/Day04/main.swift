
func meetCriteriaPart1(password: String) -> Bool {
    guard password.count == 6 else {
        return false
    }
    var hasDouble = false
    for (char, nextChar) in zip(password, password.dropFirst()) {
        guard char <= nextChar else {
            return false
        }
        if char == nextChar {
            hasDouble = true
        }
    }
    return hasDouble
}

let validPassworrdsCountPart1 = (245318...765747).reduce(0) { result, i in
    return meetCriteriaPart1(password: String(i)) ? result + 1 : result
}
print("Part 1: \(validPassworrdsCountPart1)")

func meetCriteriaPart2(password: String) -> Bool {
    guard password.count == 6 else {
        return false
    }

    var repeatingCount = 1
    var hasDouble = false
    for (char, nextChar) in zip(password, password.dropFirst()) {
        guard char <= nextChar else {
            return false
        }
        if char == nextChar {
            repeatingCount += 1
        } else {
            if repeatingCount == 2 {
                hasDouble = true
            }
            repeatingCount = 1
        }
    }
    if repeatingCount == 2 {
        hasDouble = true
    }
    return hasDouble
}

let validPassworrdsCountPart2 = (245318...765747).reduce(0) { result, i in
    return meetCriteriaPart2(password: String(i)) ? result + 1 : result
}
print("Part 2: \(validPassworrdsCountPart2)")
