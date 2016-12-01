import Foundation

let path = NSBundle.mainBundle().pathForResource("day06_input", ofType: "txt")
let input = try String(contentsOfFile: path!)

let grid = Grid()
for var l in input.componentsSeparatedByString("\n") {
    grid.operate(l)
}
let task1Solution = grid.countLightsLit() // 400410

let grid2 = Grid2()
for var l in input.componentsSeparatedByString("\n") {
    grid2.operate(l)
}
let task2Solution = grid2.countBrightness() // 15343601
