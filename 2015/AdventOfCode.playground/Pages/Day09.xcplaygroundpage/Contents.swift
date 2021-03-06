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

struct Connection {
    let start:String
    let end:String
    let distance:Int
    
    init(string: String) {
        var c = string.componentsSeparatedByString(" = ")
        distance = Int(c.last!)!
        c = c.first!.componentsSeparatedByString(" to ")
        start = c.first!
        end = c.last!
    }
}

let input = "London to Dublin = 464\nLondon to Belfast = 518\nDublin to Belfast = 141"
let connections = input.componentsSeparatedByString("\n").map{ line -> Connection in
    return Connection(string: line)
}

var cities = Set<String>()
for connection in connections {
    cities.insert(connection.start)
    cities.insert(connection.end)
}

var shortestDistance = Int.max
var shortestRoute = ""
for route in permutations(Array(cities)) {
    
    var distance = 0
    
    for i in 0..<route.count - 1 {
        let start = route[i]
        let end = route[i+1]
        for c in connections {
            if ((c.start == start && c.end == end) || (c.start == end && c.end == start)) {
                distance += c.distance
                break
            }
        }
    }
    
    if distance < shortestDistance {
        shortestDistance = distance
        shortestRoute = "\(route)"
    }
//    print("\(route) = \(distance)")
}

print("Shortest: \(shortestRoute) = \(shortestDistance)")
