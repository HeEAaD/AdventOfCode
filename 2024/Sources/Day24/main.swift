import Foundation

let inputSections = input.components(separatedBy: "\n\n")

let wires: [String: Bool] = inputSections[0]
    .split(whereSeparator: \.isNewline)
    .reduce(into: [:]) { wires, line in
        let components = line.split(separator: ":")
        let wire = String(components[0])
        switch components[1] {
        case " 0":
            wires[wire] = false
        case " 1":
            wires[wire] = true
        default:
            fatalError()
        }
    }

let connections: [Connection] = inputSections[1]
    .split(whereSeparator: \.isNewline)
    .map { line -> Connection in
        let components = line.split(separator: " ").map { String($0) }
        return Connection(
            operation: Operation(rawValue: components[1])!,
            left: components[0],
            right: components[2],
            output: components[4]
        )
    }

task1(wires, connections)
task2(wires, connections)

// MARK - Methods

struct Connection {
    let operation: Operation
    let left: String
    let right: String
    let output: String
}

extension Connection: CustomStringConvertible {
    var description: String {
        "\(left) \(operation) \(right) -> \(output)"
    }
}

enum Operation: String {
    case and = "AND"
    case or = "OR"
    case xor = "XOR"
}

func task1(_ wires: [String: Bool], _ connections: [Connection]) {
    var wires = wires
    var queue = connections
    while let connection = queue.popLast() {
        if let left = wires[connection.left], let right = wires[connection.right] {
            wires[connection.output] = switch connection.operation {
            case .and:
                left && right
            case .or:
                left || right
            case .xor:
                left != right
            }
        } else {
            queue = [connection] + queue
        }
    }

    let binary = wires
        .filter { $0.key.hasPrefix("z") }
        .sorted { $0.key > $1.key }
        .map { $0.value ? "1" : "0" }
        .joined()

    print("Answer 1:", Int(binary, radix: 2)!)
}

func task2(_ wires: [String: Bool], _ connections: [Connection]) {
    // Full adder description: https://upload.wikimedia.org/wikipedia/commons/6/69/Full-adder_logic_diagram.svg
    // Assuming full adder, output needs to be XOR
    print()
    print("Outputs without XOR:")
    connections.filter { $0.output.hasPrefix("z") && $0.operation != .xor }.forEach { print($0) }

    //kbb or gnn -> z45 (but is last digit)
    //wgq and wtm -> z33
    //fmh or tqs -> z13
    //y19 and x19 -> z19

    // Assuming carry block is OR with AND inputs
    print()
    print("OR with non AND inputs")
    for connection in connections where connection.operation == .or {
        connections
            .filter { ($0.output == connection.left || $0.output == connection.right) && $0.operation != .and }
            .forEach { print(connection, "NON AND INPUT:", $0) }
    }
    //fvk or hgj -> wvn NON AND INPUT: wtm xor wgq -> hgj
    //dgm or cph -> crr NON AND INPUT: rsm xor fnq -> cph
    //nnt or tqw -> hcb NON AND INPUT: y09 xor x09 -> nnt

    // Check manually:

    // x09 issue:
    //y09 XOR x09 -> nnt (SWAP, needs to be gws)
    //    pcd XOR gws -> z09
    //    gws AND pcd -> tqw
    //x09 AND y09 -> gws (SWAP, needs to be nnt)
    //    nnt OR tqw -> hcb

    // x13 issue:
    //x13 XOR y13 -> kvr
    //    hgw XOR kvr -> npf (SWAP, needs to be z13)
    //    hgw AND kvr -> tqs
    //x13 AND y13 -> fmh
    //    fmh OR tqs -> z13 (SWAP, needs to be npf)

    // x19 issue:
    //x19 XOR y19 -> fnq
    //    rsm XOR fnq -> cph (SWAP, needs to be z19)
    //    rsm AND fnq -> dgm
    //y19 AND x19 -> z19 (SWAP, needs to be cph)
    //    dgm OR cph -> crr

    // x33 issue:
    //x33 XOR y33 -> wtm
    //    wtm XOR wgq -> hgj (SWAP, needs to be z33)
    //    wgq AND wtm -> z33 (SWAP, needs to be hgj)
    //x33 AND y33 -> fvk
    //    fvk OR hgj -> wvn

    print()
    let swapOutputs: [String] = ["nnt", "gws", "npf", "z13", "cph", "z19", "hgj", "z33"]
    print("Answer 2:", swapOutputs.sorted().joined(separator: ","))
}
