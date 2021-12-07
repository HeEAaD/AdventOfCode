let positions = input.split(separator: ",").map { Int($0)! }

var minFuel1 = Int.max
var minFuel2 = Int.max

for endPos in positions.min()!...positions.max()! {
	var fuel1 = 0
	var fuel2 = 0
	for position in positions {
		let distance = abs(endPos - position)
		fuel1 += distance
		fuel2 += (distance * (distance + 1)) / 2
	}
	if fuel1 < minFuel1 {
		minFuel1 = fuel1
	}
	if fuel2 < minFuel2 {
		minFuel2 = fuel2
	}
}

print("Answer 1: \(minFuel1)")
print("Answer 2: \(minFuel2)")
