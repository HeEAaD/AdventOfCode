let lines = input
    .split(whereSeparator: \.isNewline)
    .map { String($0) }

struct Tile: Hashable {
    let col: Int
    let row: Int
}

extension Tile {

    init(steps: String) {
        var col = 0
        var row = 0
        var index = steps.startIndex
        while index < steps.endIndex {
            let twoCharEnd = steps.index(after: index)
            if steps[index] == "e" {
                col += 1
                index = steps.index(after: index)
            } else if steps[index] == "w" {
                col -= 1
                index = steps.index(after: index)
            } else if steps[index...twoCharEnd] == "se" {
                row += 1
                if row % 2 != 0 {
                    col += 1
                }
                index = steps.index(after: twoCharEnd)
            } else if steps[index...twoCharEnd] == "sw" {
                row += 1
                if row % 2 == 0 {
                    col -= 1
                }
                index = steps.index(after: twoCharEnd)
            } else if steps[index...twoCharEnd] == "nw" {
                row -= 1
                if row % 2 == 0 {
                    col -= 1
                }
                index = steps.index(after: twoCharEnd)
            } else if steps[index...twoCharEnd] == "ne" {
                row -= 1
                if row % 2 != 0 {
                    col += 1
                }
                index = steps.index(after: twoCharEnd)
            } else {
                fatalError()
            }
        }
        self.init(col: col, row: row)
    }

    var neighbors: [Tile] {
        if self.row % 2 == 0 {
            return [
                Tile(col: self.col, row: self.row - 1),
                Tile(col: self.col + 1, row: self.row - 1),
                Tile(col: self.col - 1, row: self.row),
                Tile(col: self.col + 1, row: self.row),
                Tile(col: self.col, row: self.row + 1),
                Tile(col: self.col + 1, row: self.row + 1),
            ]
        } else {
            return [
                Tile(col: self.col - 1, row: self.row - 1),
                Tile(col: self.col, row: self.row - 1),
                Tile(col: self.col - 1, row: self.row),
                Tile(col: self.col + 1, row: self.row),
                Tile(col: self.col - 1, row: self.row + 1),
                Tile(col: self.col, row: self.row + 1),
            ]
        }
    }
}

var blackTiles: Set<Tile> = []

for line in lines {
    let tile = Tile(steps: line)
    if blackTiles.remove(tile) == nil {
        blackTiles.insert(tile)
    }
}

print("Answer 1: \(blackTiles.count)")

for _ in 1...100 {
    var newBlackTiles: Set<Tile> = []
    var whiteTiles: Set<Tile> = []
    for blackTile in blackTiles {
        let neighbors = blackTile.neighbors
        let whiteNeighbors = neighbors.filter { !blackTiles.contains($0) }
        whiteTiles.formUnion(whiteNeighbors)
        let blackNeighborsCount = 6 - whiteNeighbors.count
        if blackNeighborsCount == 1 || blackNeighborsCount == 2 {
            newBlackTiles.insert(blackTile)
        }
    }

    for whiteTile in whiteTiles {
        let blackNeighborsCount = whiteTile.neighbors.filter { blackTiles.contains($0) }.count
        if blackNeighborsCount == 2 {
            newBlackTiles.insert(whiteTile)
        }
    }

    blackTiles = newBlackTiles
}

print("Answer 2: \(blackTiles.count)")
