// Manipulating strings is really slow. Use a boolean array instead and turn on optimization.

func step(a: [Bool]) -> [Bool] {
    let b = a.reversed().map { !$0 }
    return a + [false] + b
}

func checksum(a: [Bool]) -> [Bool] {
    var sum = [Bool]()
    for i in stride(from: 0, to: a.count, by: 2) {
        let c = a[i] == a[i+1]
        sum.append(c)
    }
    return sum.count % 2 == 0 ? checksum(a: sum) : sum
}

func task(a: String, length: Int) -> String {
    var a = a.characters.map { $0 == "1" }
    while a.count < length {
        a = step(a: a)
    }
    a = Array(a[0..<length])
    return checksum(a: a).map { $0 ? "1" : "0" }.joined()
}

let task1 = task(a: "11011110011011101", length: 272)
print("Task 1: \(task1)") // 00000100100001100

let task2 = task(a: "11011110011011101", length: 35_651_584)
print("Task 2: \(task2)") // 00011010100010010
