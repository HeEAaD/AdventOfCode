// MARK: TASK 1

struct Edge {
    let start: Character
    let end: Character
}

let edges: [Edge] = input
    .split(separator: "\n")
    .map { Edge(start: $0[$0.index($0.startIndex, offsetBy: 5)],
                end: $0[$0.index($0.startIndex, offsetBy: 36)]) }

func nextEdge(edges: [Edge]) -> Edge {
    let candidates = edges.filter { edge in
        return !edges.map({ $0.end }).contains(edge.start)
    }

    return candidates
        .sorted { lhs, rhs in
            if lhs.start == rhs.start {
                return lhs.end < rhs.end
            }
            return lhs.start < rhs.start
        }
        .first!
}

func description(of chars: [Character]) -> String {
    var d = ""
    for c in chars {
        d.append(c)
    }
    return d
}

var remainingEdges = edges
var path = [Edge]()
while !remainingEdges.isEmpty {
    let edge = nextEdge(edges: remainingEdges)
    path.append(edge)
    remainingEdges.removeAll { $0.start == edge.start }
}

var jobs = path.map { $0.start }
jobs.append(path.last!.end)
print("Task 1: \(description(of: jobs))")

// MARK: TASK 2

struct Worker {
    var assigned: Character?
    var remaining = 0
}

let workersCount = 5
let offset = 60

var second = -1
var workers = Array(repeating: Worker(assigned: nil, remaining: 0), count: workersCount)
var open = jobs
var done = [Character]()

while done.count < jobs.count {
    second += 1

    for i in 0..<workers.count {
        if let assigned = workers[i].assigned {
            if workers[i].remaining == 0 {
                // unassign
                done.append(assigned)
                workers[i].assigned = nil
                workers[i].remaining = 0
            } else {
                workers[i].remaining -= 1
            }
        }
    }

    for i in 0..<workers.count where workers[i].assigned == nil {

        // find next
        let next = open.first { char in
            let deps = edges.filter { $0.end == char }.map { $0.start }
            return deps.isEmpty || deps.allSatisfy { done.contains($0) }
        }

        // assign
        if let next = next {
            workers[i].assigned = next
            workers[i].remaining = Int(next.unicodeScalars.first!.value) - 65 + offset
            open.removeAll { $0 == next }
        } else {
            break
        }
    }

    var debug = "\(second)"
    for worker in workers {
        debug.append(" \(worker.assigned ?? ".")")
    }
    debug.append(" Done: \(description(of: done)) Open: \(description(of: open))")
    print(debug)
}

print("Task 2: \(second)")
