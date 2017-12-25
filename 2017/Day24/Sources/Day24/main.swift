let components = [
    (48, 5),
    (25, 10),
    (35, 49),
    (34, 41),
    (35, 35),
    (47, 35),
    (34, 46),
    (47, 23),
    (28, 8),
    (27, 21),
    (40, 11),
    (22, 50),
    (48, 42),
    (38, 17),
    (50, 33),
    (13, 13),
    (22, 33),
    (17, 29),
    (50, 0),
    (20, 47),
    (28, 0),
    (42, 4),
    (46, 22),
    (19, 35),
    (17, 22),
    (33, 37),
    (47, 7),
    (35, 20),
    (8, 36),
    (24, 34),
    (6, 7),
    (7, 43),
    (45, 37),
    (21, 31),
    (37, 26),
    (16, 5),
    (11, 14),
    (7, 23),
    (2, 23),
    (3, 25),
    (20, 20),
    (18, 20),
    (19, 34),
    (25, 46),
    (41, 24),
    (0, 33),
    (3, 7),
    (49, 38),
    (47, 22),
    (44, 15),
    (24, 21),
    (10, 35),
    (6, 21),
    (14, 50)
]

typealias Component = (Int, Int)
typealias Bridge = [Component] // components maybe reversed

func buildBridges(bridge: Bridge) -> [Bridge] {

    let port = bridge.last?.1 ?? 0

    var newBridges = [Bridge]()

    for component in components {

        let componentToAdd: Component
        if component.0 == port {
            componentToAdd = component
        } else if component.1 == port {
            componentToAdd = (component.1, component.0)
        } else {
            continue
        }

        if bridge.contains(where: { $0 == componentToAdd || $0 == (componentToAdd.1, componentToAdd.0) }) {
            continue
        }

        var bridge = bridge
        bridge.append(componentToAdd)
        newBridges.append(bridge)
        newBridges.append(contentsOf: buildBridges(bridge: bridge))
    }

    return newBridges
}

func strength(of bridge: Bridge) -> Int {
    return bridge.reduce(0, { $0 + $1.0 + $1.1 })
}

let bridges = buildBridges(bridge: [])

let task1 = bridges.map(strength).max()!

print("Task1: \(task1)")

var longesBridges = [Bridge]()

for bridge in bridges {
    let longestBridgeCount = longesBridges.first?.count ?? 0
    if bridge.count > longestBridgeCount {
        longesBridges = [bridge]
    } else if bridge.count == longestBridgeCount {
        longesBridges.append(bridge)
    }
}

let task2 = longesBridges.map(strength).max()!

print("Task2: \(task2)")
