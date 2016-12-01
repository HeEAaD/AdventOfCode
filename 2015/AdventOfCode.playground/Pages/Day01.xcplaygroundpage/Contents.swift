import Foundation

let path = NSBundle.mainBundle().pathForResource("day01_input", ofType: "txt")
let input = try String(contentsOfFile: path!)

var floor = 0
var firstBasement = -1

for (i, char) in input.characters.enumerate() {
    floor += char == "(" ? 1 : char == ")" ? -1 : 0
    if floor == -1 && firstBasement == -1 {
        firstBasement = i + 1
    }
}

floor // task 1
firstBasement // task 2
