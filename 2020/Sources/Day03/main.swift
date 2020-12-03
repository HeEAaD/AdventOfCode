let grid = input.split(whereSeparator: \.isNewline)
    .map { line in
        line.map { $0 == Character("#") }
    }

func traverse(_ slope: (right: Int, down: Int)) -> Int {
    var trees = 0
    var j = 0
    let width = grid[0].count
    for i in stride(from: 0, to: grid.count, by: slope.down) {
        if grid[i][j] {
            trees += 1
        }
        j = (j + slope.right) % width
    }
    return trees
}

let trees1 = traverse((3, 1))
print("Answer 1: \(trees1)")

let product = trees1
    * traverse((1, 1))
    * traverse((5, 1))
    * traverse((7, 1))
    * traverse((1, 2))
print("Answer 2: \(product)")
