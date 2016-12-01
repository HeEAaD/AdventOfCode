
// To continue, please consult the code grid in the manual.  Enter the code at row 2981, column 3075. 

/*
   | 1   2   3   4   5   6
---+---+---+---+---+---+---+
 1 |  1   3   6  10  15  21
 2 |  2   5   9  14  20
 3 |  4   8  13  19
 4 |  7  12  18
 5 | 11  17
 6 | 16
*/

func iterations(row: Int,_ column:Int) -> Int {
    var iterations = (row-1)*row / 2 + 1 // molecular formula
    for i in 1..<column {
        iterations += row + i
    }
    return iterations
}

var code = 20151125
for _ in 1..<iterations(2981,3075) {
    code = code * 252533 % 33554393
}
print("Task 1: \(code)") // 9132360
