import Foundation

let path = ((#file as NSString).deletingLastPathComponent as NSString).appendingPathComponent("input.txt")
let instructions = try String(contentsOfFile: path)
    .trimmingCharacters(in: .whitespacesAndNewlines)
    .split(separator: "\n")
    .map { $0.split(separator: " ").map(String.init) }

func task1() -> Int {
    var p = 0
    var registers = [
        "a": 0,
        "b": 0,
        "c": 0,
        "d": 0,
        "e": 0,
        "f": 0,
        "g": 0,
        "h": 0
    ]

    var mulCount = 0

    while p < instructions.count {
        let instruction = instructions[p]
        let instruction2 = instruction.count == 3 ? instruction[2] : nil

        switch (instruction[0], instruction[1], instruction2) {
        case let ("set", r, v?):
            registers[r] = Int(v) ?? registers[v]!
            p += 1
        case let ("sub", r, v?):
            registers[r] = (registers[r]!) - (Int(v) ?? registers[v]!)
            p += 1
        case let ("mul", r, v?):
            registers[r] = (registers[r]!) * (Int(v) ?? registers[v]!)
            p += 1
            mulCount += 1
        case let ("jnz", r, v?):
            p += (Int(r) ?? registers[r]!) != 0 ? (Int(v) ?? registers[v]!) : 1
        default:
            fatalError()
        }
    }

    return mulCount
}

func task2() -> Int {
    let a = 1
    var b = 0
    var c = 0
    var d = 0
    var e = 0
    var f = 0
    var g = 0
    var h = 0

    b = 84 // set b 84
    c = b // set c b
    if a != 0 { // jnz a 2
        // jnz 1 5
        b *= 100 // mul b 100
        b -= -100000 // sub b -100000
        c = b // set c b
        c -= -17000 // sub c -17000
    }

    repeat {
        f = 1 // set f 1
        d = 2 // set d 2
        repeat {
            e = 2 // set e 2
            repeat {
                g = d // set g d
                g = g * e // mul g e
                g = g - b // sub g b
                if g == 0 { // jnz g 2
                    f = 0 // set f 0
                }
                e -= -1 // sub e -1
                g = e // set g e
                g = g - b // sub g b
            } while g != 0 // jnz g -8
            d -= -1 // sub d -1
            g = d // set g d
            g = g - b // sub g b
        } while g != 0 // jnz g -13
        if f == 0 { // jnz f 2
            h -= -1 // sub h -1
        }
        g = b // set g b
        g = g - c // sub g c
        if g == 0 { // jnz g 2
            break // jnz 1 3
        }
        b -= -17 // sub b -17
    } while true // jnz 1 -23

    return h
}

func task2Optimized() -> Int {

    var b = 108400
    let c = b + 17000 // sub c -17000
    var h = 0

    repeat {
        var f = 1 // set f 1
        var d = 2 // set d 2
        repeat {
            if b % d == 0 && d != b {
                f = 0
                break
            }
            d += 1 // sub d -1
        } while d != b // jnz g -13
        if f == 0 { // jnz f 2
            h += 1 // sub h -1
        }
        if b == c { // jnz g 2
            break // jnz 1 3
        }
        b += 17 // sub b -17
    } while true // jnz 1 -23

    return h
}

print("Task1: \(task1())")
print("Task2: \(task2Optimized())")
