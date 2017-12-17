let stepSize = 324

func task1() -> Int {
    var buffer = [0]
    var p = 0

    for i in 1...2017 {
        p = (p + stepSize) % i
        p += 1
        buffer.insert(i, at: p)
    }

    return buffer[p+1]
}

func task2() -> Int {
    // buffer[0] is 0 always, therefore we're looking for buffer[1]
    var bufferIndex1 = -1
    var p = 0

    for i in 1...50_000_000 {
        p = (p + stepSize) % i
        p += 1
        if p == 1 {
            bufferIndex1 = i
        }
    }

    return bufferIndex1
}

print("Task1: \(task1())")
print("Task2: \(task2())")
