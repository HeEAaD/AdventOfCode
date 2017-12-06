let banks = [4, 10, 4, 1, 8, 4, 9, 14, 5, 1, 14, 15, 0, 15, 3, 5]

func permutate(array: [Int]) -> [Int] {
    var array = array
    var selectedE = array[0]
    var selectedI = 0
    for (i, e) in array.enumerated() {
        if e > selectedE {
            selectedE = e
            selectedI = i
        }
    }
    array[selectedI] = 0
    for _ in 0..<selectedE {
        selectedI = (selectedI + 1) % array.count
        array[selectedI] = array[selectedI] + 1
    }
    return array
}

func run(_ banks: [Int]) -> (task1: Int, task2: Int) {
    var count = 0
    var permutation = banks
    var permutations = Array<[Int]>()

    while true {
        count += 1
        permutation = permutate(array: permutation)
        if let index = permutations.index(where: { $0 == permutation }) {
            return (task1: count, task2: permutations.count - Int(index))
        }
        permutations.append(permutation)
    }
    fatalError()
}

let (task1, task2) = run(banks)
print("Task 1: \(task1)")
print("Task 2: \(task2)")
