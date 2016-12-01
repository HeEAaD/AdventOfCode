import Foundation

//let containers = [20, 15, 10, 5, 5]
let containers = [33,14,18,20,45,35,16,35,1,13,18,13,50,44,48,6,24,41,30,42]

/// less memory consumtion for task 1
func fillCount(containers:[Int], sum:Int) -> Int {
    var variants = 0
    
    for i in 0..<containers.count {
        let pivot = containers[i]
        let remainingSum = sum - pivot
        var remaining:[Int] = []
        for c in containers[i+1..<containers.count] {
            switch c - remainingSum {
            case 0:
                variants += 1
            case let d where d < 0:
                remaining.append(c)
            default: break
            }
        }
        variants += fillCount(remaining, sum: remainingSum)
    }
    return variants
}

func fillVariants(containers:[Int], sum:Int) -> [[Int]] {
    var variants:[[Int]] = []
    
    for i in 0..<containers.count {
        let pivot = containers[i]
        let remainingSum = sum - pivot
        var remaining:[Int] = []
        for c in containers[i+1..<containers.count] {
            switch c - remainingSum {
            case 0:
                variants.append([pivot,c])
            case let d where d < 0:
                remaining.append(c)
            default: break
            }
        }
        for v in fillVariants(remaining, sum: remainingSum) {
            variants.append([pivot] + v)
        }
    }
    return variants
}


print("Task1: \(fillCount(containers,sum:150))") // 1304

let variants = fillVariants(containers, sum:150)
var shortestVariantLength = Int.max
var shortestVariantCount = 0
for v in variants {
    if v.count < shortestVariantLength {
        shortestVariantLength = v.count
        shortestVariantCount = 1
    } else if v.count == shortestVariantLength {
        shortestVariantCount += 1
    }
    
}
print("Task2: \(shortestVariantCount)") // 18
