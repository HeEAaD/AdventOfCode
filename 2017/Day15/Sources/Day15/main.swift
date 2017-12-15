func task1() -> Int {
    var a = 873
    var b = 583
    var matches = 0
    for _ in 0..<40_000_000 {
        a = (a * 16807) % 2147483647
        b = (b * 48271) % 2147483647
        if a & 0xffff == b & 0xffff {
            matches += 1
        }
    }
    return matches
}

func task2() -> Int {
    var a = 873
    var b = 583
    var matches = 0
    for _ in 0..<5_000_000 {
        repeat {
            a = (a * 16807) % 2147483647
        } while a % 4 != 0

        repeat {
            b = (b * 48271) % 2147483647
        } while b % 8 != 0

        if a & 0xffff == b & 0xffff {
            matches += 1
        }
    }
    return matches
}

print("Task1: \(task1())")
print("Task2: \(task2())")
