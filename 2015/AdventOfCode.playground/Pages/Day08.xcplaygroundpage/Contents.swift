import Foundation

extension String {
    private func unescapeASCII() -> String {
        let reqex = try! NSRegularExpression(pattern: "\\\\x[0-9a-f]{2}", options: .CaseInsensitive)
        let matches = reqex.matchesInString(self, options: [], range: NSMakeRange(0, self.characters.count))
        var unescaped = self
        for match in matches {
            let startIndex = self.startIndex.advancedBy(match.range.location)
            let endIndex = self.startIndex.advancedBy(match.range.location+match.range.length)
            let subString = self.substringWithRange(startIndex..<endIndex)
            let scalarString = self.substringWithRange(startIndex.advancedBy(2)..<endIndex)
            let scalar = UnicodeScalar(UInt8(strtoul(scalarString, nil, 16)))
            unescaped = unescaped.stringByReplacingOccurrencesOfString(subString, withString: String(scalar))
        }
        return unescaped
    }
    
    func unescape() -> String {
        var unescaped = self.substringWithRange(self.startIndex.advancedBy(1)..<self.endIndex.advancedBy(-1))
        unescaped = unescaped.stringByReplacingOccurrencesOfString("\\\"", withString: "\"")
        unescaped = unescaped.unescapeASCII()
        unescaped = unescaped.stringByReplacingOccurrencesOfString("\\\\", withString: "\\")
        return unescaped
    }
    
    func escape() -> String {
        var escaped = self
        escaped = escaped.stringByReplacingOccurrencesOfString("\\", withString: "\\\\")
        escaped = escaped.stringByReplacingOccurrencesOfString("\"", withString: "\\\"")
        return "\"" + escaped + "\""
    }
}

let path = NSBundle.mainBundle().pathForResource("day08_input", ofType: "txt")
let input = try String(contentsOfFile: path!).componentsSeparatedByString("\n")

let task1Solution = input.reduce(0) { n, s in
    n + s.characters.count - s.unescape().characters.count
} // 1350

print(input[2].escape())
let task2Solution = input.reduce(0) { n, s in
    n + s.escape().characters.count - s.characters.count
} // 2085
