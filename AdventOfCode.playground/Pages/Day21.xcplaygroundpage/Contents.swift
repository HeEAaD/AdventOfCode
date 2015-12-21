struct Item {
    let name: String
    var cost: Int
    var damage: Int
    var armor: Int
}

extension Item:Equatable {}
func ==(lhs: Item, rhs: Item) -> Bool {
    return lhs.name == rhs.name
}

extension Item:Comparable {}
func <(lhs: Item, rhs: Item) -> Bool {
    return lhs.cost < rhs.cost
}

let weapons = [
    Item(name: "Dagger", cost: 8, damage: 4, armor: 0),
    Item(name: "Shortsword", cost: 10, damage: 5, armor: 0),
    Item(name: "Warhammer", cost: 25, damage: 6, armor: 0),
    Item(name: "Longsword", cost: 40, damage: 7, armor: 0),
    Item(name: "Greataxe", cost: 74, damage: 8, armor: 0)
]

let armors = [
    Item(name: "Leather", cost: 13, damage: 0, armor: 1),
    Item(name: "Chainmail", cost: 31, damage: 0, armor: 2),
    Item(name: "Splintmail", cost: 53, damage: 0, armor: 3),
    Item(name: "Bandedmail", cost: 75, damage: 0, armor: 4),
    Item(name: "Platemail", cost: 102, damage: 0, armor: 5)
]

let rings = [
    Item(name: "Damage +1", cost: 25, damage: 1, armor: 0),
    Item(name: "Damage +2", cost: 50, damage: 2, armor: 0),
    Item(name: "Damage +3", cost: 100, damage: 3, armor: 0),
    Item(name: "Defense +1", cost: 20, damage: 0, armor: 1),
    Item(name: "Defense +2", cost: 40, damage: 0, armor: 2),
    Item(name: "Defense +3", cost: 80, damage: 0, armor: 3)
]

/*!
- returns: true if i win
*/
func fight(myDamage:Int,_ myArmor:Int) -> Bool {
    
    var bossHitPoints = 100
    var myHitPoints = 100
    let bossDamage = 8
    let bossArmor = 2

    for round in 0..<Int.max {
        if round % 2 == 0 {
            bossHitPoints -= myDamage - bossArmor
            if bossHitPoints <= 0 {
                return true
            }
        } else {
            myHitPoints -= bossDamage - myArmor
            if myHitPoints <= 0 {
                return false
            }
        }
    }
    
    assert(false)
    return false
}

let possibleArmors = [[]] + armors.map { [$0] }
var possibleRings:[[Item]] = [[]]
for ring in rings {
    possibleRings.append([ring])
    for ring2 in rings where ring2 != ring {
        possibleRings.append([ring,ring2])
    }
}

var settings:[[Item]] = []
for weapon in weapons {
    let setting = [weapon]
    for armor in possibleArmors {
        let withArmorSetting = setting + armor
        for possibleRing in possibleRings {
            settings.append(withArmorSetting + possibleRing)
        }
    }
}

let sortedCombined = settings.map {
    $0.reduce(Item(name: "me combined", cost: 0, damage: 0, armor: 0)) { combined, item in
        Item(name: combined.name, cost: combined.cost + item.cost, damage: combined.damage + item.damage, armor: combined.armor + item.armor)
    }
}.sort()

for combined in sortedCombined {
    if fight(combined.damage, combined.armor) {
        print("Task 1: \(combined.cost)") // 91
        break
    }
}

for combined in sortedCombined.reverse() {
    if !fight(combined.damage, combined.armor) {
        print("Task 2: \(combined.cost)") // 158
        break
    }
}
