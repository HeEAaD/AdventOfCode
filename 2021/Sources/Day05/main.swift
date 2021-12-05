struct Coord: Hashable {
	let x: Int
	let y: Int
}

var coords1: [Coord:Int] = [:]
var coords2: [Coord:Int] = [:]

input
	.split(whereSeparator: \.isNewline)
	.forEach { line in
		let words = line.split(separator: " ")
		let startCoords = words[0].split(separator: ",")
		let endCoords = words[2].split(separator: ",")
		let x1 = Int(startCoords[0])!
		let y1 = Int(startCoords[1])!
		let x2 = Int(endCoords[0])!
		let y2 = Int(endCoords[1])!

		if x1 == x2 {
			for y in y1 <= y2 ? y1...y2 : y2...y1 {
				coords1[Coord(x: x1, y: y), default: 0] += 1
				coords2[Coord(x: x1, y: y), default: 0] += 1
			}
		} else if y1 == y2 {
			for x in x1 <= x2 ? x1...x2 : x2...x1 {
				coords1[Coord(x: x, y: y1), default: 0] += 1
				coords2[Coord(x: x, y: y1), default: 0] += 1
			}
		} else if abs(x1 - x2) == abs(y1 - y2) {
			if x1 <= x2 && y1 <= y2 {
				for i in 0...(x2 - x1) {
					coords2[Coord(x: x1 + i, y: y1 + i), default: 0] += 1
				}
			} else if x1 > x2 && y1 <= y2 {
				for i in 0...(x1 - x2) {
					coords2[Coord(x: x1 - i, y: y1 + i), default: 0] += 1
				}
			} else if x1 > x2 && y1 > y2 {
				for i in 0...(x1 - x2) {
					coords2[Coord(x: x1 - i, y: y1 - i), default: 0] += 1
				}
			} else if x1 <= x2 && y1 > y2 {
				for i in 0...(x2 - x1) {
					coords2[Coord(x: x1 + i, y: y1 - i), default: 0] += 1
				}
			}
		}
	}

let totalOverlaps1 = coords1.values.reduce(into: 0) { $1 > 1 ? $0 += 1 : () }
print("Answer 1: \(totalOverlaps1)")

let totalOverlaps2 = coords2.values.reduce(into: 0) { $1 > 1 ? $0 += 1 : () }
print("Answer 2: \(totalOverlaps2)")
