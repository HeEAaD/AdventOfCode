struct Race {
    let time: Int
    let recordDistance: Int

    func wins() -> Int {
        let firstWinTime = (1..<time).first { holdButtonTime in
            let speed = holdButtonTime
            let remainingTime = time - holdButtonTime
            let distance = speed * remainingTime
            return distance > recordDistance
        }!

        let lastWinTime = (firstWinTime..<time).last { holdButtonTime in
            let speed = holdButtonTime
            let remainingTime = time - holdButtonTime
            let distance = speed * remainingTime
            return distance > recordDistance
        }!

        return lastWinTime - firstWinTime + 1
    }
}

let races = [
    Race(time: 58, recordDistance: 478),
    Race(time: 99, recordDistance: 2232),
    Race(time: 64, recordDistance: 1019),
    Race(time: 69, recordDistance: 1071)
]

print("Answer 1:", races.reduce(1) { $0 * $1.wins() })

let race = Race(time: 58996469, recordDistance: 478223210191071)
print("Answer 2:", race.wins())
