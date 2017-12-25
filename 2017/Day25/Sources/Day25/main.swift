/*
 Begin in state A.
 Perform a diagnostic checksum after 12261543 steps.
 
 In state A:
 If the current value is 0:
 - Write the value 1.
 - Move one slot to the right.
 - Continue with state B.
 If the current value is 1:
 - Write the value 0.
 - Move one slot to the left.
 - Continue with state C.
 
 In state B:
 If the current value is 0:
 - Write the value 1.
 - Move one slot to the left.
 - Continue with state A.
 If the current value is 1:
 - Write the value 1.
 - Move one slot to the right.
 - Continue with state C.
 
 In state C:
 If the current value is 0:
 - Write the value 1.
 - Move one slot to the right.
 - Continue with state A.
 If the current value is 1:
 - Write the value 0.
 - Move one slot to the left.
 - Continue with state D.
 
 In state D:
 If the current value is 0:
 - Write the value 1.
 - Move one slot to the left.
 - Continue with state E.
 If the current value is 1:
 - Write the value 1.
 - Move one slot to the left.
 - Continue with state C.
 
 In state E:
 If the current value is 0:
 - Write the value 1.
 - Move one slot to the right.
 - Continue with state F.
 If the current value is 1:
 - Write the value 1.
 - Move one slot to the right.
 - Continue with state A.
 
 In state F:
 If the current value is 0:
 - Write the value 1.
 - Move one slot to the right.
 - Continue with state A.
 If the current value is 1:
 - Write the value 1.
 - Move one slot to the right.
 - Continue with state E.
*/

enum State {
    case a, b, c, d, e, f
}

enum Move {
    case left, right
}

struct Transition {
    let write: Int
    let move: Move
    let nextState: State
}

let transitions: [State: [Transition]] = [
    .a: [Transition(write: 1, move: .right, nextState: .b), Transition(write: 0, move: .left, nextState: .c)],
    .b: [Transition(write: 1, move: .left, nextState: .a), Transition(write: 1, move: .right, nextState: .c)],
    .c: [Transition(write: 1, move: .right, nextState: .a), Transition(write: 0, move: .left, nextState: .d)],
    .d: [Transition(write: 1, move: .left, nextState: .e), Transition(write: 1, move: .left, nextState: .c)],
    .e: [Transition(write: 1, move: .right, nextState: .f), Transition(write: 1, move: .right, nextState: .a)],
    .f: [Transition(write: 1, move: .right, nextState: .a), Transition(write: 1, move: .right, nextState: .e)]
]

let steps = 12261543
var tape = Array(repeating: 0, count: steps)
var cursor = tape.count / 2
var state = State.a

for _ in 0..<steps {

    let value = tape[cursor]
    let transition = transitions[state]![value]

    tape[cursor] = transition.write

    switch transition.move {
    case .left: cursor -= 1
    case .right: cursor += 1
    }

    state = transition.nextState
}

let checksum = tape.reduce(0, +)
print("Task1: \(checksum)")
