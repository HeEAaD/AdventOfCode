import Foundation

infix operator >>= {}
func >>=<A, B>(xs: [A], f: A -> [B]) -> [B] {
    return xs.map(f).reduce([], combine: +)
}

extension Array {
    var decompose : (head: Element, tail: [Element])? {
        return (count > 0) ? (self[0], Array(self[1..<count])) : nil
    }
}

func between<T>(x: T, _ ys: [T]) -> [[T]] {
    if let (head, tail) = ys.decompose {
        return [[x] + ys] + between(x, tail).map { [head] + $0 }
    } else {
        return [[x]]
    }
}

func permutations<T>(xs: [T]) -> [[T]] {
    if let (head, tail) = xs.decompose {
        return permutations(tail) >>= { permTail in
            between(head, permTail)
        }
    } else {
        return [[]]
    }
}

/// Thats functions is very inefficent
func greatestHappiness(connections:[(a:String,h:Int,b:String)]) -> Int {
    let persons = Array(Set<String>(connections.reduce([]) { $0 + [$1.a] }))
    let personsP = permutations(persons)
    var greatestHappiness = Int.min
    for persons in personsP {
        var happiness = 0
        for i in 0..<persons.count {
            let ni = (i + 1) % persons.count
            let pi = (i + persons.count - 1) % persons.count
            for c in connections {
                if c.a == persons[i] {
                    if c.b == persons[ni] || c.b == persons[pi] {
                        happiness += c.h
                    }
                }
            }
        }
        if happiness > greatestHappiness {
            greatestHappiness = happiness
        }
    }
    return greatestHappiness
}

let input = try! String(contentsOfFile: "input.txt")

var connections = input.componentsSeparatedByString("\n").map { line -> (a:String,h:Int,b:String) in
    let words = line.stringByReplacingOccurrencesOfString(".", withString: "").componentsSeparatedByString(" ")
    var h = Int(words[3])!
    if words[2] == "lose" {
        h *= -1
    }
    return (words[0],h,words[10])
}

print("Task1: \(greatestHappiness(connections))") // 709

let persons = Array(Set<String>(connections.reduce([]) { $0 + [$1.a] }))
for p in persons {
    connections = connections + [("Me",0,p), (p,0,"Me")]
}
print("Task2: \(greatestHappiness(connections))") // 668
