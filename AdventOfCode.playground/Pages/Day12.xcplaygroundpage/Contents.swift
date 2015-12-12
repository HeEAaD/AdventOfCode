import Foundation

let path = NSBundle.mainBundle().pathForResource("input", ofType: "json")!

let string = try! String(contentsOfFile: path)
let regex = try! NSRegularExpression(pattern: "-[0-9]+|[0-9]+", options: [])
let matches = regex.matchesInString(string, options: [], range: NSMakeRange(0, string.characters.count))
let task1 = matches.map{ Int((string as NSString).substringWithRange($0.range))! }.reduce(0) { $0 + $1 }
print("Task1: \(task1)")

func sumWithoutRed(object:AnyObject) -> Int {
    switch object {
    case let a as Array<AnyObject>:
        return a.reduce(0) { $0 + sumWithoutRed($1) }
    case let d as Dictionary<String,AnyObject>:
        var count = 0
        for v in d.values {
            switch v {
            case let s as String where s == "red": return 0
            default: count += sumWithoutRed(v)
            }
        }
        return count
    case let i as Int:
        return i
    default:
        return 0
    }
}

let data = try! NSData(contentsOfFile: path)!
let jsonDict = try! NSJSONSerialization.JSONObjectWithData(data, options:[])
let task2 = sumWithoutRed(jsonDict)
print("Task2: \(task2)")