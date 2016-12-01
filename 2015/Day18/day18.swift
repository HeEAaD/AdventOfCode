import Foundation

let input = try! String(contentsOfFile: "input.txt")
let inputGrid = input.componentsSeparatedByString("\n").map { $0.characters.map { $0 == "#" } }

func print(grid:[[Bool]]) {
    for xRow in grid {
        print(xRow.map{ $0 ? "#" : "." }.joinWithSeparator(""))
    }
    print("")
}

func count(grid:[[Bool]]) -> Int {
    return grid.reduce(0) { $1.reduce($0) { $0 + ($1 ? 1 : 0) } }
}

func step(grid:[[Bool]], skipCorners: Bool = false) -> [[Bool]] {
   
    var result = Array(count: grid.count, repeatedValue: Array(count: grid[0].count, repeatedValue: false))
    
    for x in 0..<grid.count {
        for y in 0..<grid[x].count {
            
            if skipCorners
                && ((x == 0 && (y == 0 || y == grid[x].count - 1))
                || (x == grid.count - 1 && (y == 0 || y == grid[x].count - 1))) {
                
                result[x][y] = true
                continue
            }
            
            var on = 0
            if x > 0 {
                let xRow = grid[x-1]
                if xRow[y] {
                    on += 1
                }
                if y > 0 && xRow[y-1] {
                    on += 1
                }
                if y < xRow.count - 1 && xRow[y+1] {
                    on += 1
                }
            }
            if x < grid.count - 1 {
                let xRow = grid[x+1]
                if xRow[y] {
                    on += 1
                }
                if y > 0 && xRow[y-1] {
                    on += 1
                }
                if y < xRow.count - 1 && xRow[y+1] {
                    on += 1
                }
            }
            
            let xRow = grid[x]
            if y > 0 && xRow[y-1] {
                on += 1
            }
            if y < xRow.count - 1 && xRow[y+1] {
                on += 1
            }
            
            if grid[x][y] {
                result[x][y] = on == 2 || on == 3
            } else {
                result[x][y] = on == 3
            }
        }
    }
    return result
}

var grid = inputGrid
for _ in 0..<100 {
    grid = step(grid)
}
print("Task 1: \(count(grid))") // 814

grid = inputGrid
grid[0][0] = true
grid[0][grid[0].count - 1] = true
grid[grid.count - 1][0] = true
grid[grid.count - 1][grid[0].count - 1] = true
for _ in 0..<100 {
    grid = step(grid,skipCorners:true)
}
print("Task 2: \(count(grid))") // 924
