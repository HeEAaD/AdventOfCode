let groups = input
    .split(omittingEmptySubsequences: false, whereSeparator: \.isNewline)
    .split(separator: "")

let fields: [String: [ClosedRange<Int>]] = groups[0].reduce(into: [:]) { fields, line in
    let components = line.split(separator: ":")
    let name = String(components[0])
    fields[name] = components[1].split(separator: " ").reduce(into: [ClosedRange<Int>]()) { ranges, word in
        guard word != "or" else { return }
        let components = word.split(separator: "-")
        ranges.append(Int(components[0])!...Int(components[1])!)
    }
}

let yourTicket: [Int] = groups[1]
    .last!
    .split(separator: ",")
    .map { Int($0)! }

let nearbyTickets: [[Int]] = groups[2]
    .dropFirst()
    .map { $0.split(separator: ",").map { Int($0)! } }

let allRanges = fields.values.flatMap { $0 }

var errorRate = 0
var validTickets: [[Int]] = []

for nearbyTicket in nearbyTickets {
    let invalidValues = nearbyTicket.filter { value in
        !allRanges.contains(where: { $0.contains(value) })
    }
    if invalidValues.isEmpty {
        validTickets.append(nearbyTicket)
    } else {
        errorRate += invalidValues.reduce(into: 0, { $0 += $1 })
    }
}

print("Answer 1: \(errorRate)")

var possibleFields: [Set<String>] = Array(repeating: Set(fields.keys), count: yourTicket.count)

for ticket in validTickets {
    for (i, value) in ticket.enumerated() {
        possibleFields[i] = possibleFields[i].filter { field in
            fields[field]!.contains(where: { $0.contains(value) })
        }
    }

    var removed = false
    repeat {
        removed = false
        for i in 0..<possibleFields.count where possibleFields[i].count == 1 {
            for j in 0..<possibleFields.count where i != j {
                removed = removed || possibleFields[j].remove(possibleFields[i].first!) != nil
            }
        }
    } while removed
}

assert(possibleFields.allSatisfy({ $0.count == 1 }))
let orderedFields = possibleFields.map { $0.first! }

var product = 1
for (i, field) in orderedFields.enumerated() where field.hasPrefix("departure")  {
    product *= yourTicket[i]
}

print("Answer 2: \(product)")
