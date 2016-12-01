import Foundation

let path = NSBundle.mainBundle().pathForResource("day02_input", ofType: "txt")
let input = try String(contentsOfFile: path!)

let dimensions = input
    .componentsSeparatedByString("\n")
    .map { $0.componentsSeparatedByString("x")
        .map { Int($0)! }.sort() }

let totalPaper = dimensions.reduce(0) { s, d in
    let a = d[0]
    let b = d[1]
    let c = d[2]
    let area = 2*a*b + 2*a*c + 2*b*c
    let bonus = a * b
    return s + area + bonus
}

let totalRibbon = dimensions.reduce(0) { s, d in
    let a = d[0]
    let b = d[1]
    let c = d[2]
    let ribbon = a+a+b+b
    let bow = a * b * c
    return s + ribbon + bow
}
