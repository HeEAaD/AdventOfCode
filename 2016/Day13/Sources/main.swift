let seed = 1352
let start = (x: 1, y: 1)
let end = (x: 31, y: 39)

typealias Coord = (x: Int, y: Int)
let offsets: [Coord] = [(x: -1, y: 0), (x: 1, y: 0), (x: 0, y: -1), (x: 0, y: 1)]

func isWall(_ coord: Coord) -> Bool {
    let x = coord.x
    let y = coord.y
    let n = x*x + 3*x + 2*x*y + y + y*y + seed
    let binaryString = String(n, radix: 2)
    let numberOfOnes = binaryString.characters.reduce(0) { $1 == "1" ? $0 + 1 : $0 }

    return numberOfOnes % 2 == 1
}

func isValid(_ c: Coord) -> Bool {
    return c.x >= 0 && c.y >= 0 && !isWall(c)
}

func findShortesPath(task2: Bool = false) -> Int {
    var visited = Array(repeating: Array(repeatElement(false, count: 50)), count: 50) // guessed size
    visited[start.x][start.y] = true
    var q = [(c: start, d: 0)]

    while !q.isEmpty {
        let curr = q.removeFirst()
        if task2 && curr.d >= 50 { // task 2
            continue
        } else if curr.c.x == end.x && curr.c.y == end.y {
            return curr.d
        }

        for offset in offsets {
            let nextCoord: Coord = (x: curr.c.x + offset.x, y: curr.c.y + offset.y)

            if !isValid(nextCoord) || visited[nextCoord.x][nextCoord.y] {
                continue
            }

            visited[nextCoord.x][nextCoord.y] = true
            q.append((c: nextCoord, d: curr.d + 1))
        }
    }

    if task2 {
        return visited.reduce(0) { $0 + $1.reduce(0) { $1 ? $0 + 1 : $0 }}
    }

    return Int.max
}

print("Task1: \(findShortesPath())") // 90,
print("Task2: \(findShortesPath(task2: true))") // 135
