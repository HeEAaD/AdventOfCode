struct Robot: Hashable {
    let vx: Int
    let vy: Int

    var px: Int
    var py: Int
}

//let roomWidth = 11
//let roomHeight = 7
let roomWidth = 101
let roomHeight = 103

let robots: [Robot] = input
    .matches(of: /p=(-?\d+),(-?\d+) v=(-?\d+),(-?\d+)/)
    .map { match in
        Robot(
            vx: Int(match.3)!,
            vy: Int(match.4)!,
            px: Int(match.1)!,
            py: Int(match.2)!
        )
    }

print("Answer 1", task1(robots: robots, roomWidth: roomWidth, roomHeight: roomHeight))
task2(robots: robots, roomWidth: roomWidth, roomHeight: roomHeight)

// MARK: - Methods

func task1(robots: [Robot], roomWidth: Int, roomHeight: Int) -> Int {
    var robots = robots
    move(&robots, steps: 100, roomWidth: roomWidth, roomHeight: roomHeight)
    return safetyFactor(
        robots: robots,
        roomWidth: roomWidth,
        roomHeight: roomHeight
    )
}

func task2(robots: [Robot], roomWidth: Int, roomHeight: Int) {
    var robots = robots
    // Looks like a picture forms at this interval: steps % 101 == 86
    move(&robots, steps: 86, roomWidth: roomWidth, roomHeight: roomHeight)
    for i in 1..<67 {
        print()
        print("step:", 86 + i * 101)
        move(&robots, steps: 101, roomWidth: roomWidth, roomHeight: roomHeight)
        print(robots: robots, roomWidth: roomWidth, roomHeight: roomHeight)
    }
}

func safetyFactor(robots: [Robot], roomWidth: Int, roomHeight: Int) -> Int {
    var countLT = 0
    var countRT = 0
    var countLB = 0
    var countRB = 0
    for robot in robots {
        if robot.px < roomWidth / 2, robot.py < roomHeight / 2 {
            countLT += 1
        } else if robot.px < roomWidth / 2, robot.py > roomHeight / 2 {
            countLB += 1
        } else if robot.px > roomWidth / 2, robot.py < roomHeight / 2 {
            countRT += 1
        } else if robot.px > roomWidth / 2, robot.py > roomHeight / 2 {
            countRB += 1
        }
    }
    return countLT * countRT * countLB * countRB
}

func move(_ robots: inout [Robot], steps: Int, roomWidth: Int, roomHeight: Int) {
    for i in robots.indices {
        robots[i].px = (robots[i].px + robots[i].vx * steps) % roomWidth
        robots[i].py = (robots[i].py + robots[i].vy * steps) % roomHeight
        if robots[i].px < 0 {
            robots[i].px += roomWidth
        }
        if robots[i].py < 0 {
            robots[i].py += roomHeight
        }
    }
}

func print(robots: [Robot], roomWidth: Int, roomHeight: Int) {
    var picture = ""
    for y in 0..<roomHeight {
        for x in 0..<roomWidth {
            let count = robots.count(where: { $0.px == x && $0.py == y })
            picture += count > 0 ? String(count) : " "
        }
        picture += "\n"
    }
    print(picture)
}
