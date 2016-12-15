struct Disk {
    let positions: Int
    let positionAtZeroTime: Int

    func passesAtTime(_ time: Int) -> Bool {
        return ((positionAtZeroTime + time) % positions) == 0
    }
}

let disks = [
    Disk(positions: 17, positionAtZeroTime: 15),
    Disk(positions: 3, positionAtZeroTime: 2),
    Disk(positions: 19, positionAtZeroTime: 4),
    Disk(positions: 13, positionAtZeroTime: 2),
    Disk(positions: 7, positionAtZeroTime: 2),
    Disk(positions: 5, positionAtZeroTime: 0),
    Disk(positions: 11, positionAtZeroTime: 0) // Task 2
]

var task1 = 0
for startTime in 0..<Int.max {
    var passes = true
    for (i, disk) in disks.enumerated() {
        let time = startTime + i + 1
        if !disk.passesAtTime(time) {
            passes = false
            break
        }
    }

    if passes {
        task1 = startTime
        break
    }
}

print("Task1: \(task1)") // 400589, 3045959
