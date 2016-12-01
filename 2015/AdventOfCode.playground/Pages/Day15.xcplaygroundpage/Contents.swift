import Foundation

let input = "Sprinkles: capacity 2, durability 0, flavor -2, texture 0, calories 3\nButterscotch: capacity 0, durability 5, flavor -3, texture 0, calories 3\nChocolate: capacity 0, durability 0, flavor 5, texture -1, calories 8\nCandy: capacity 0, durability -1, flavor 0, texture 5, calories 8"

struct Vec5d {
    var e0,e1,e2,e3,e4:Int
    
    mutating func multiplyWithScalar(scalar: Int) {
        e0 *= scalar
        e1 *= scalar
        e2 *= scalar
        e3 *= scalar
        e4 *= scalar
    }
    
    func addVec(vec:Vec5d) -> Vec5d {
        return Vec5d(e0: e0+vec.e0, e1: e1+vec.e1, e2: e2+vec.e2, e3: e3+vec.e3, e4: e4+vec.e4)
    }
}

let incredients = input.componentsSeparatedByString("\n")
    .map { $0.componentsSeparatedByString(",").map  { Int($0.componentsSeparatedByString(" ").last!)!}}
    .map { Vec5d(e0:$0[0],e1:$0[1],e2:$0[2],e3:$0[3],e4:$0[4])}

func total(scalars:[Int], var incredients:[Vec5d], validSum: Vec5d -> Bool) -> Int {
    for i in 0..<incredients.count {
        incredients[i].multiplyWithScalar(scalars[i])
    }
    let sum = incredients.reduce(Vec5d(e0: 0, e1: 0, e2: 0, e3: 0, e4: 0)) { $0.addVec($1) }
    return  validSum(sum) ? sum.e0*sum.e1*sum.e2*sum.e3 : 0
}

func totalTask2(scalars:[Int], var incredients:[Vec5d]) -> Int {
    for i in 0..<incredients.count {
        incredients[i].multiplyWithScalar(scalars[i])
    }
    let sum = incredients.reduce(Vec5d(e0: 0, e1: 0, e2: 0, e3: 0, e4: 0)) { $0.addVec($1) }
    if sum.e0 < 0 || sum.e1 < 0 || sum.e2 < 0 || sum.e3 < 0 || sum.e4 != 500 {
        return 0
    }
    return sum.e0*sum.e1*sum.e2*sum.e3
}

var maxTask1 = Int.min
var maxTask2 = Int.min
for s0 in 1...97 {
    for s1 in 1...98 - s0 {
        for s2 in 1...99 - s0 - s1 {
            let s3 = 100 - s0 - s1 - s2
            let t1 = total([s0,s1,s2,s3], incredients:incredients) { (sum:Vec5d) -> Bool in
                return sum.e0 > 0 && sum.e1 > 0 && sum.e2 > 0 && sum.e3 > 0
            }
            let t2 = total([s0,s1,s2,s3], incredients:incredients) { (sum:Vec5d) -> Bool in
                return sum.e0 > 0 && sum.e1 > 0 && sum.e2 > 0 && sum.e3 > 0 && sum.e4 == 500
            }   
            if t1 > maxTask1 {
                maxTask1 = t1
            }
            if t2 > maxTask2 {
                maxTask2 = t2
            }
        }
    }
}
print("Task1: \(maxTask1)")
print("Task2: \(maxTask2)")
