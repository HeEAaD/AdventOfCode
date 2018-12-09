// naiive, a lot of array operations: O(n^2)
func highscore(players: Int, marbles: Int) -> Int {

    var circle = [0]
    var current = 0
    var scores = Array(repeating: 0, count: players)
    for marble in 1...marbles {
        let player = marble % players
        if marble % 23 == 0 {
            scores[player] += marble
            current = (current - 7) % circle.count
            if current < 0 {
                current += circle.count
            }
            scores[player] += circle.remove(at: current)
        } else {
            current = ((current + 1) % circle.count) + 1
            circle.insert(marble, at: current)
        }
    }
    return scores.max()!
}

assert(highscore(players: 9, marbles: 25) == 32)
assert(highscore(players: 10, marbles: 1618) == 8317)
assert(highscore(players: 13, marbles: 7999) == 146373)
assert(highscore(players: 17, marbles: 1104) == 2764)
assert(highscore(players: 21, marbles: 6111) == 54718)
assert(highscore(players: 30, marbles: 5807) == 37305)

print("Task 1: \(highscore(players: 419, marbles: 72164))")

class Node {
    let value: Int
    var next: Node!
    var prev: Node!
    init(value: Int) {
        self.value = value
    }
}

// linked list approach: O(n)
func highscoreLinkedList(players: Int, marbles: Int) -> Int {

    let node = Node(value: 0)
    node.prev = node
    node.next = node
    var current = node
    var scores = Array(repeating: 0, count: players)

    for marble in 1...marbles {
        if marble % 23 == 0 {
            let player = marble % players
            for _ in 0..<7 {
                current = current.prev
            }
            let m = current.value
            scores[player] += marble
            scores[player] += m
            current.prev.next = current.next
            current.next.prev = current.prev
            current = current.next
        } else {
            let oldNext = current.next.next!
            let newNode = Node(value: marble)
            current.next.next = newNode
            newNode.prev = current.next
            newNode.next = oldNext
            oldNext.prev = newNode
            current = newNode
        }
    }
    return scores.max()!
}

assert(highscoreLinkedList(players: 9, marbles: 25) == 32)
assert(highscoreLinkedList(players: 10, marbles: 1618) == 8317)
assert(highscoreLinkedList(players: 13, marbles: 7999) == 146373)
assert(highscoreLinkedList(players: 17, marbles: 1104) == 2764)
assert(highscoreLinkedList(players: 21, marbles: 6111) == 54718)
assert(highscoreLinkedList(players: 30, marbles: 5807) == 37305)

// 419 players; last marble is worth 72164 points
print("Task 2: \(highscoreLinkedList(players: 419, marbles: 7216400))")
