#!/usr/bin/env xcrun swift -O

// inefficent
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
    if a == [] { return [] }
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

var a = [1,3,2,1,1,3,1,1,1,2]
for i in 1...40 {
    a = f(a)
}
print("Task 1: \(a.count)")
for i in 41...50 {
    a = f(a)
}
print("Task 2: \(a.count)")