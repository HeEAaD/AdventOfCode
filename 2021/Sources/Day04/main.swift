let lines = input
	.split(omittingEmptySubsequences: false, whereSeparator: \.isNewline)

let numbers = lines
	.first!
	.split(separator: ",")
	.map { Int($0)! }

let boards = lines
	.split(whereSeparator: { $0 == "" })
	.dropFirst()
	.map { boardRows in
		boardRows.map { row in
			row.split(whereSeparator: \.isWhitespace).map { Int($0)! }
		}
	}

func mark(boards: inout [[[Int]]], number: Int) {
	for b in 0..<boards.count {
		for l in 0..<boards[b].count {
			for c in 0..<boards[b][l].count {
				if boards[b][l][c] == number {
					boards[b][l][c] = -1
				}
			}
		}
	}
}

func isCompleted(board: [[Int]]) -> Bool {
	for row in board where row.allSatisfy({ $0 == -1 }) {
		return true
	}

	for c in 0..<board[0].count {
		var allMarked = true
		for row in board where row[c] != -1 {
			allMarked = false
			break
		}
		if allMarked {
			return true
		}
	}
	return false
}

func sum(board: [[Int]]) -> Int {
	board.reduce(into: 0) { partialResult, line in
		partialResult += line.reduce(into: 0) { partialResult, cell in
			guard cell != -1 else { return }
			partialResult += cell
		}
	}
}

func play(boards: [[[Int]]]) -> Int {
	var boards = boards
	for number in numbers {
		mark(boards: &boards, number: number)
		if let completedBoard = boards.first(where: isCompleted(board:)) {
			return sum(board: completedBoard) * number
		}
	}
	fatalError()
}

func play2(boards: [[[Int]]]) -> Int {
	var boards = boards
	for number in numbers {
		mark(boards: &boards, number: number)
		var lastCompletedBoard: [[Int]]!
		boards = boards.filter { board in
			if isCompleted(board: board) {
				lastCompletedBoard = board
				return false
			}
			return true
		}
		if boards.isEmpty {
			return sum(board: lastCompletedBoard) * number
		}
	}

	fatalError()
}

print("Answer 1: \(play(boards: boards))")
print("Answer 2: \(play2(boards: boards))")
