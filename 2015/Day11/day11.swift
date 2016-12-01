#!/usr/bin/env xcrun swift -O

import Foundation

func isValid(password:NSString) -> Bool {
    
    let range = NSMakeRange(0, password.length)
    
    var regex = try! NSRegularExpression(pattern: "[iol]", options: [])
    if regex.firstMatchInString(password as String, options: [], range: range) != nil {
        return false
    }
    
    regex = try! NSRegularExpression(pattern: "(.)\\1.*(.)\\2", options: [])
    if regex.firstMatchInString(password as String, options: [], range: range) == nil {
        return false
    }
    
    regex = try! NSRegularExpression(pattern: "(abc|bcd|cde|def|efg|fgh|pqr|qrs|rst|stu|tuv|uvw|vwx|wxy|xyz)", options: [])
    if regex.firstMatchInString(password as String, options: [], range: range) == nil {
        return false
    }
    
    return true
}

func increment(string:NSString) -> NSString {
    
    guard string != "" else { return "" }
    
    let lastChar = string.characterAtIndex(string.length - 1)
    let left = string.substringToIndex(string.length - 1)
    
    if lastChar >= 122 { // z
        return NSString(format:"%@a", increment(left))
    } else {
        return NSString(format:"%@%c", left, lastChar + 1)
    }
}

func nextPassword(var password: NSString) -> NSString {
    repeat {
        password = increment(password)
    } while !isValid(password)
    return password
}

var password:NSString = "hepxcrrq"
password = nextPassword(password)
print("Task1: \(password)")
password = nextPassword(password)
print("Task2: \(password)")
