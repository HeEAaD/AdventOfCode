import Foundation

let path = ((#file as NSString).deletingLastPathComponent as NSString).appendingPathComponent("input.txt")
let input = try String(contentsOfFile: path)
    .split(separator: "\n")
    .filter { !$0.isEmpty }

struct Scanner {
    let range: Int
    var position = 0
    private var movesDown = false

    init(range: Int) {
        self.range = range
    }

    mutating func move() {
        if position == range - 1 || position == 0 {
            movesDown = !movesDown
        }
        position += movesDown ? 1 : -1
    }
}

func initialScanners() -> [Int: Scanner] {
    return input.reduce([Int: Scanner]()) { scanners, line in
        var scanners = scanners
        let ints = line.split(separator: ":").map { Int($0.trimmingCharacters(in: .whitespaces))! }
        scanners[ints[0]] = Scanner(range: ints[1])
        return scanners
    }
}

func movedScanners(_ scanners: [Int: Scanner]) -> [Int: Scanner] {
    return scanners.mapValues { (scanner: Scanner) -> Scanner in
        var scanner = scanner
        scanner.move()
        return scanner
    }
}

func task1() -> Int {
    var scanners = initialScanners()
    var serverity = 0
    for depth in 0...scanners.keys.max()! {
        if let scanner = scanners[depth], scanner.position == 0 {
            serverity += depth * scanner.range
        }
        scanners = movedScanners(scanners)
    }

    return serverity
}

func isHit(scanners: [Int: Scanner]) -> Bool {
    var scanners = scanners
    for depth in 0...scanners.keys.max()! {
        if let scanner = scanners[depth], scanner.position == 0 {
            return true
        }
        scanners = movedScanners(scanners)
    }

    return false
}

func task2() -> Int {
    var scanners = initialScanners()
    for delay in 0...Int.max {
        if !isHit(scanners: scanners) {
            return delay
        }
        scanners = movedScanners(scanners)
    }
    fatalError()
}

print("Task1: \(task1())")
print("Task2: \(task2())")
