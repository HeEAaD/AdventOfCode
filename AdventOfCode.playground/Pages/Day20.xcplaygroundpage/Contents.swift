import Foundation

let max = 1_000_000
var houses = Array(count: max, repeatedValue: 0)
for i in 1...max {
//  for j in i...max where j % i == 0 { // swifty, but slow
    for (var j = i; j<=max; j += i) {
        houses[j-1] += i
    }
}
for (i,n) in houses.enumerate() {
    if n >= 3_400_000 {
        print("Task1: \(i+1)")
        break
    }
}

houses = Array(count: max, repeatedValue: 0)
for i in 1...max {
    var visit = 0
//  for j in i...max where j % i == 0 { // swifty, but slow
    for (var j = i; j<=max; j += i) {
        houses[j-1] += i * 11
        visit += 1
        if visit == 50 {
            break
        }
    }
}
for (i,n) in houses.enumerate() {
    if n >= 34_000_000 {
        print("Task2: \(i+1)")
        break
    }
}
