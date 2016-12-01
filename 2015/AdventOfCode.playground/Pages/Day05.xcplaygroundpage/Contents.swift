import Foundation

// I tried to solve this tasks without regular expressions

extension String {
    var vowels:Int {
        return characters
            .filter { "aeiou".containsString(String($0)) }
            .count
    }
    
    var containsDoubleLetters: Bool {
        for i in 1..<characters.count {
            if self[startIndex.advancedBy(i-1)] == self[startIndex.advancedBy(i)] {
                return true
            }
        }
        return false
    }
    
    var containsDirtySubstrings: Bool {
        return containsString("ab") ||
               containsString("cd") ||
               containsString("pq") ||
               containsString("xy")
    }
    
    var containsDoubleLettersTwice: Bool {
        for i in 0...characters.count - 2 {
            let range = Range(start: startIndex.advancedBy(i), end: startIndex.advancedBy(i + 2))
            let doubleLetter = substringWithRange(range)
            let rest = substringFromIndex(startIndex.advancedBy(i + 2))
            if rest.containsString(doubleLetter) {
                return true
            }
        }
        return false
    }
    
    var containsSameLetterWithOneLetterBetween: Bool {
        for i in 0...characters.count - 3 {
            let range = Range(start: startIndex.advancedBy(i), end: startIndex.advancedBy(i + 3))
            let subChars = substringWithRange(range).characters
            if subChars.first == subChars.last {
                return true
            }
        }
        return false
    }
    
    var isCleanForTask1: Bool {
        return vowels >= 3 && containsDoubleLetters && !containsDirtySubstrings
    }
    
    var isCleanForTask2: Bool {
        return containsDoubleLettersTwice && containsSameLetterWithOneLetterBetween
    }
}

let path = NSBundle.mainBundle().pathForResource("day05_input", ofType: "txt")
let input = try String(contentsOfFile: path!)

let task1Solution = input
    .componentsSeparatedByString("\n")
    .filter{ $0.isCleanForTask1 }
    .count

let task2Solution = input
    .componentsSeparatedByString("\n")
    .filter{ $0.isCleanForTask2 }
    .count
