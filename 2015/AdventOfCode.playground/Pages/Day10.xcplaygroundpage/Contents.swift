import Foundation

/// split([1,2,1,1]) -> [1] + split([2,1,1])
/// split([2,1,1]) -> [2] + split([1,1])
/// split([1,1]) -> [1,1] + split([])
/// split([]) -> [[]]
/// split([1]) -> [[1]]
//func split(a: [Int]) -> [[Int]] {
//    if a == [] {
//        return [[]]
//    }
//    for i in 0..<a.count - 1{
//        if a[i] != a[i+1] {
//            let head = Array(a[0...i])
//            let tail = Array(a[i+1..<a.count])
//            return [head] + split(tail)
//        }
//    }
//    return [a]
//}

///// f([1,2,1,1]) -> [1,1] + f([2,1,1])
///// f([2,1,1]) -> [1,2] + f([1,1])
///// f([1,1]) -> [2,1] + f([])
///// f([]) -> []
//func f(a: [Int]) -> [Int] {
//    if a == [] {
//        return []
//    }
//    for i in 0..<a.count - 1{
//        if a[i] != a[i+1] {
//            let tail = Array(a[i+1..<a.count])
//            return [i+1] + [a[i]] + f(tail)
//        }
//    }
//    return [a.count,a[0]]
//}

func f(a: [Int]) -> [Int] {
    if a == [] {
        return []
    }
    
    var result = Array<Int>()
    var b = 0
    for i in 0..<a.count {
        if i == a.count - 1 || a[i] != a[i+1] {
            result += [i - b + 1,a[i]]
            b = i + 1
        }
    }
    
    return result
}

// example
f([1])
f([1,1])
f([2,1])
f([1,2,1,1])
f([1,1,1,2,2,1])

var a = [1,3,2,1,1,3,1,1,1,2]
for i in 0..<40 {
    a = f(a)
}
a

