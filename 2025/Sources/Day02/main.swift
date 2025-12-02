func isInvalid(_ iArray: [UInt8], partitions: Int) -> Bool {
    assert(partitions >= 2)

    guard iArray.count.isMultiple(of: partitions) else {
        return false
    }

    let partSize = iArray.count / partitions
    let first = iArray[0..<partSize]
    for p in 1..<partitions {
        let part = iArray[partSize * p..<partSize * (p + 1)]
        if part != first {
            return false
        }
    }
    return true
}

let ranges = input.split(separator: ",").map { range in
    let bounds = range.split(separator: "-").map { Int($0)! }
    return bounds[0]...bounds[1]
}

let (sum0, sum1) = await withTaskGroup(of: (sum0: Int, sum1: Int).self) { taskGroup in
    for range in ranges {
        taskGroup.addTask {
            var invalidSum = 0
            var invalidSum2 = 0
            for i in range.lowerBound...range.upperBound {
                let iArray = String(i).map { UInt8(String($0))! }

                if isInvalid(iArray, partitions: 2) {
                    invalidSum += i
                    invalidSum2 += i
                    continue
                }

                guard iArray.count > 2 else { continue }
                for p in 3...iArray.count {
                    if isInvalid(iArray, partitions: p) {
                        invalidSum2 += i
                        break
                    }
                }
            }
            return (invalidSum, invalidSum2)
        }
    }

    var total = (0, 0)
    for await sums in taskGroup {
        total.0 += sums.sum0
        total.1 += sums.sum1
    }
    return total
}

print("Answer 1:", sum0)
print("Answer 2:", sum1)
