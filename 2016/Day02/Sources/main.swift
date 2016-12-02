let input = [
    "RLRDDRLLDLRLUDDULLDRUUULDDLRLUDDDLDRRDUDDDLLURDDDLDDDRDURUDRDRRULUUDUDDRRRLRRRRRLRULRLLRULDRUUDRLRRURDDRLRULDLDULLLRULURRUULLRLLDDDDLLDURRUDLDLURDRDRDLUUUDDRDUUDDULLUURRDRLDDULURRRUDLLULULDLLURURUDRRRRUDRLRDLRRLDDRDDLULDLLLURURDUDRRRRUULURLRDULDRLUDRRUDDUULDURUDLDDURRRDLULLUUDRLLDUUDLDRUDDRLLLLLLDUDUDDLRDLRRDRUDDRRRLLRRDLLRLDDURUURRRDDLDUULLDLDLRURDLLLDDRUUDRUDDDDULRLLDUULRUULLLULURRRLLULDLDUDLDLURUDUDULLDLLUUDRRDRLUURURURURDLURUUDLDRLUDDUUDULDULULLLDLDDULLULLDULRRDRULLURRRULLDDDULULURLRDURLLURUDDULLRUDLRURURRDRDUULDRUUDURDURDDLRDUUULDUUDRDURURDRRRURLLDDLLLURURULULUDLRDLDRDRURLRLULRDLU",
    "UDLDURRULDRDDLDUULUDLDUULUURDDRUDRURRRUDRURLLDDRURLDLRDUUURDLLULURDDUDDDRRRURLLDLDLULRDULRLULDLUUDLLRLDLRUUULDDUURDLDDRRDLURLDUDDRURDRRURDURRRLUULURDDLRDLDRRRLDUDRLRLLRLDDUULDURUUULLLRRRRRRRDRRRDRLUULDLDDLULDRDUDLLUDRRUDRUUDULRLUURDDDDRRUUDLURULLLURDULUURDRDDURULRUDRRDLRDUUUUUDDDRDRDDRUDRDDDRLRUUDRDRDDDLUDRDRLDRDDRULURDRLDRUDUDRUULRLLUDRDRLLLLDUDRRLLURDLLLDRRUDDUDRLRLDUDRLURRUUULURDDRUURRLDRLRRRUUDLULDDDRDLDUUURLLUULDDRRUDLDDRUDUDUURURDDRDULLLLLULRRRDLRRRDDDLURDDDDLUULLLRDDURRRRLURRLDDLRUULULRDRDDDDLDUUUUUUDRRULUUUDD",
    "UURDRRUDLURRDDDLUDLRDURUDURDLLLLRDLRLRDDRDRDUUULRDLLDLULULRDUDDRRUUDURULDLUDLRDRUDLDDULLLDDRDLLDULLLURLLRDDLDRDULRRDDULRDURLLRUDRLRRLUDURLDRDLDLRLLLURLRRURDLDURDLUDULRDULLLDRDDRDLDRDULUULURDRRRLDRRUULULLDDRRLDLRUURLRUURLURRLLULUUULRLLDDUDDLRLDUURURUDLRDLURRLLURUDLDLLUDDUULUUUDDDURDLRRDDDLDRUDRLRURUUDULDDLUUDDULLDDRRDDRRRUDUDUDLDLURLDRDLLLLDURDURLRLLLUUDLRRRRUDUDDLDLRUURRLRRLUURRLUDUDRRRRRRRLDUDDRUDDLUDLRDDDRLDUULDRDRRDLDRURDLDRULRLRLUDRDLRRUURUUUUDLDUUULLLRRRRRDLRRURDDLLLLUULDLLRULLUDLLDLLUDLRLRRLRURDDRRL",
    "URDRDLLRDDDLLLDDLURLRURUURRRLUURURDURRLLUDURRLRLDLUURDLULRRDRUDDLULDLDRLDLRLRRLLLDDDUDDDLRURURRLLDRRRURUDLRDDLLDULDDLDRLUUUDRRRULDUULRDDDLRRLLURDDURLULRDUDURRLLDLLRLDUDDRRDDLRLLLDUDRLUURRLLDULRLDLUUUUUDULUDLULUDDUURRURLDLDRRLDLRRUDUDRRDLDUDDLULLDLLRDRURDRDRRLDDDDRDDRLLDDDLLUDRURLURDRRRRRUDDDUDUDDRDUUDRRUDUDRLULDDURULUURUUUURDRULRLRULLDDRRRUULRRRRURUDLDLRDLLDRLURLRUULLURDUDULRRURLRLLRRLLLURULRRRLDDUULLUUULRRDRULUUUUDRDRRDLRURLRLLRLRRRDRDRLDLUURUURULLDLULRRLRRDRULRRLLLDDURULLDLDLDLUUURDLDLUUDULRLLUDDRRDLLDLDLDURLUURRDDRRURDRLUDRLUUUDLDULDLUDRLDUDDLLRUDULLLLLDRRLLUULLUUURRDDUURDLLRDDLRLLU",
    "LDUDRRDLUUDDRLLUUULURLDUDLUDLRLDRURLULRLLDDLRRUUUDDDDRDULDDUUDLRUULDRULLRDRUDDURLDUUURRUDUDRDRDURRDLURRRDRLDLRRRLLLRLURUURRDLLRDLDDLLRDUDDRDUULRULRRURLUDDUDDDUULLUURDULDULLLLRUUUDDRRRLDDDLDLRRDRDRDLUULRLULDRULDLRDRRUDULUDLLUDUULRDLRRUUDDLLDUDDRULURRLULDLDRRULDDRUUDDLURDLRDRLULRRLURRULDUURDLUDLLDRLDULLULDLLRDRDLLLUDLRULLRLDRDDDLDDDLRULDLULLRUUURRLLDUURRLRLDUUULDUURDURRULULRUUURULLLRULLURDDLDRLLRDULLUDLDRRRLLLLDUULRRLDURDURDULULDUURLDUDRLRURRDLUUULURRUDRUUUDRUR"
]

let testInput = [
    "ULL",
    "RRDDD",
    "LURDL",
    "UUUUD"
]

// MARK: Task 1

/*
 1 2 3
 4 5 6
 7 8 9
 */

/*
 x:      y:
 0 1 2   0
         1
         2
 */

/*
 ULL
 RRDDD
 LURDL
 UUUUD   -> 1985
 */

func moveTask1(from: (x: Int, y: Int), input: String) -> (x: Int, y: Int) {

    var p = from

    for character in input.characters {
        switch character {
        case "R":
            p.x = min(p.x + 1, 2)
        case "L":
            p.x = max(p.x - 1, 0)
        case "D":
            p.y = min(p.y + 1, 2)
        case "U":
            p.y = max(p.y - 1, 0)
        default:
            assertionFailure()
        }
    }

    return p
}

func numberTask1(_ coord: (x: Int, y: Int)) -> Int {
    switch coord {
    case (0, 0):
        return 1
    case (1, 0):
        return 2
    case (2, 0):
        return 3
    case (0, 1):
        return 4
    case (1, 1):
        return 5
    case (2, 1):
        return 6
    case (0, 2):
        return 7
    case (1, 2):
        return 8
    case (2, 2):
        return 9
    default:
        assertionFailure()
        return -1
    }
}

func task1(input: [String]) -> String {

    var p = (x: 1, y: 1)
    var code = [Int]()
    for line in input {
        p = moveTask1(from: p, input: line)
        code.append(numberTask1(p))
    }
    return code.map { "\($0)" }.joined()
}

//print("Task 1: \(task1(input: testInput))")
print("Task 1: \(task1(input: input))") // 18843

// MARK: Task 1
/*
 0 1 2 3 4
 
     1
   2 3 4
 5 6 7 8 9
   A B C
     D            -> 5DB3
 */
func task2(input: [String]) -> String {

    var p = (x: 0, y: 2)
    var code = ""
    for line in input {
        p = moveTask2(from: p, input: line)
        code.characters.append(charTask2(p))
    }
    return code
}

func moveTask2(from: (x: Int, y: Int), input: String) -> (x: Int, y: Int) {

    var p = from

    for character in input.characters {
        switch character {
        case "R":
            switch p.y {
            case 0, 4:
                p.x = min(p.x + 1, 2)
            case 1, 3:
                p.x = min(p.x + 1, 3)
            case 2:
                p.x = min(p.x + 1, 4)
            default:
                assertionFailure()
            }
        case "L":
            switch p.y {
            case 0, 4:
                p.x = max(p.x - 1, 2)
            case 1, 3:
                p.x = max(p.x - 1, 1)
            case 2:
                p.x = max(p.x - 1, 0)
            default:
                assertionFailure()
            }
        case "D":
            switch p.x {
            case 0, 4:
                p.y = min(p.y + 1, 2)
            case 1, 3:
                p.y = min(p.y + 1, 3)
            case 2:
                p.y = min(p.y + 1, 4)
            default:
                assertionFailure()
            }
        case "U":
            switch p.x {
            case 0, 4:
                p.y = max(p.y - 1, 2)
            case 1, 3:
                p.y = max(p.y - 1, 1)
            case 2:
                p.y = max(p.y - 1, 0)
            default:
                assertionFailure()
            }

        default:
            assertionFailure()
        }
    }

    return p

}

func charTask2(_ coord: (x: Int, y: Int)) -> Character {
    switch coord {
    case (2, 0):
        return "1"
    case (1, 1):
        return "2"
    case (2, 1):
        return "3"
    case (3, 1):
        return "4"
    case (0, 2):
        return "5"
    case (1, 2):
        return "6"
    case (2, 2):
        return "7"
    case (3, 2):
        return "8"
    case (4, 2):
        return "9"
    case (1, 3):
        return "A"
    case (2, 3):
        return "B"
    case (3, 3):
        return "C"
    case (2, 4):
        return "D"
    default:
        assertionFailure()
        return Character("")
    }
}

//print("Task 2: \(task2(input: testInput))") // 5DB3
print("Task 2: \(task2(input: input))") // 67BB9
