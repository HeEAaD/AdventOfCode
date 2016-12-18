/// - Returns: The number of save tiles
func saveTiles(input: String, totalRows: Int) -> Int {
    // "." == true, "^" == false
    var row = input.characters.map { $0 == "." }
    var saveTiles = row.reduce(0) { $1 ? $0 + 1 : $0 }

    for _ in 0..<totalRows - 1 {
        var nextRow = [Bool]()

        for i in 0..<row.count {

            let left = i == 0 ? true : row[i-1]
            let right = i == row.count - 1 ? true : row[i+1]
            nextRow.append(left == right)
        }

        saveTiles += nextRow.reduce(0) { $1 ? $0 + 1 : $0 }
        row = nextRow
    }
    return saveTiles
}

let input = "...^^^^^..^...^...^^^^^^...^.^^^.^.^.^^.^^^.....^.^^^...^^^^^^.....^.^^...^^^^^...^.^^^.^^......^^^^"

let task1 = saveTiles(input: input, totalRows: 40)
print("Task1: \(task1)") // 1982

let task2 = saveTiles(input: input, totalRows: 400000)
print("Task2: \(task2)") // 20005203
