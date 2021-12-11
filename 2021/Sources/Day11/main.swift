var grid = input
    .split(whereSeparator: \.isNewline)
    .map { $0.map { Int(String($0))! }}

let height = grid.count
let width = grid[0].count
var flashesCount = 0

for step in 1...Int.max {
    grid = grid.map { $0.map { $0 + 1 }}

    var flashesGrid = Array(repeating: Array(repeating: false, count: width), count: height)

    while true {
        var nextGrid = grid
        var flashed = false
        for i in 0..<height {
            for j in 0..<width where grid[i][j] > 9 && !flashesGrid[i][j] {
                for k in max(0, i-1)...min(i+1, height - 1) {
                    for l in max(0, j-1)...min(j+1, width - 1) {
                        nextGrid[k][l] += 1
                    }
                }
                flashesGrid[i][j] = true
                flashed = true
                flashesCount += 1
            }
        }
        grid = nextGrid
        if !flashed {
            break
        }
    }

    for i in 0..<height {
        for j in 0..<width where flashesGrid[i][j] {
            grid[i][j] = 0
        }
    }

    if step == 100 {
        print("Answer 1:", flashesCount)
    }

    if flashesGrid.allSatisfy({$0.allSatisfy({$0})}) {
        print("Answer 2:", step)
        break
    }
}
