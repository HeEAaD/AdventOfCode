let masses = input.split(separator: "\n").compactMap { Int($0) }

func fuelRequired(mass: Int) -> Int {
    return mass / 3 - 2
}

print(fuelRequired(mass: 12))
print(fuelRequired(mass: 14))
print(fuelRequired(mass: 14))
print(fuelRequired(mass: 1969))
print(fuelRequired(mass: 100756))

let sumFuelRequired = masses.map(fuelRequired).reduce(0, +)
print("Part 1: \(sumFuelRequired)")

func totalFuelRequired(mass: Int) -> Int {
    guard mass > 6 else { return 0 }
    let fuel =  mass / 3 - 2
    return fuel + totalFuelRequired(mass: fuel)
}

print(totalFuelRequired(mass: 14))
print(totalFuelRequired(mass: 1969))
print(totalFuelRequired(mass: 100756))

let sumTotalFuelRequired = masses.map(totalFuelRequired).reduce(0, +)
print("Part 2: \(sumTotalFuelRequired)")
