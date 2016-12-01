import Foundation

let path = NSBundle.mainBundle().pathForResource("input", ofType: "txt")!
var aunts = try! String(contentsOfFile: path).componentsSeparatedByString("\n")

for aunt in aunts {
    if aunt.containsString("children: ") && !aunt.containsString("children: 3")
        || aunt.containsString("cats: ") && !aunt.containsString("cats: 7")
        || aunt.containsString("samoyeds: ") && !aunt.containsString("samoyeds: 2")
        || aunt.containsString("pomeranians: ") && !aunt.containsString("pomeranians: 3")
        || aunt.containsString("akitas: ") && !aunt.containsString("akitas: 0")
        || aunt.containsString("vizslas: ") && !aunt.containsString("vizslas: 0")
        || aunt.containsString("goldfish: ") && !aunt.containsString("goldfish: 5")
        || aunt.containsString("trees: ") && !aunt.containsString("trees: 3")
        || aunt.containsString("cars: ") && !aunt.containsString("cars: 2")
        || aunt.containsString("perfumes: ") && !aunt.containsString("perfumes: 1") {
            
        if let i = aunts.indexOf(aunt) {
            aunts.removeAtIndex(i)
        }
    }
}
print("Task1: \(aunts.first!)")

aunts = try! String(contentsOfFile: path).componentsSeparatedByString("\n")

for aunt in aunts {
    if aunt.containsString("children: ") && !aunt.containsString("children: 3")
        || aunt.containsString("samoyeds: ") && !aunt.containsString("samoyeds: 2")
        || aunt.containsString("akitas: ") && !aunt.containsString("akitas: 0")
        || aunt.containsString("vizslas: ") && !aunt.containsString("vizslas: 0")
        || aunt.containsString("cars: ") && !aunt.containsString("cars: 2")
        || aunt.containsString("perfumes: ") && !aunt.containsString("perfumes: 1") {
            if let i = aunts.indexOf(aunt) {
                aunts.removeAtIndex(i)
            }
    }
    
//            || aunt.containsString("cats: ") && !aunt.containsString("cats: 7")
//            || aunt.containsString("trees: ") && !aunt.containsString("trees: 3")
//            || aunt.containsString("pomeranians: ") && !aunt.containsString("pomeranians: 3")
//            || aunt.containsString("goldfish: ") && !aunt.containsString("goldfish: 5")
}
print("Task2: one in \(aunts.joinWithSeparator("\n"))")
