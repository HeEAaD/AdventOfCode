let sampleInput = """
Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1
"""

let input = """
Monkey 0:
  Starting items: 92, 73, 86, 83, 65, 51, 55, 93
  Operation: new = old * 5
  Test: divisible by 11
    If true: throw to monkey 3
    If false: throw to monkey 4

Monkey 1:
  Starting items: 99, 67, 62, 61, 59, 98
  Operation: new = old * old
  Test: divisible by 2
    If true: throw to monkey 6
    If false: throw to monkey 7

Monkey 2:
  Starting items: 81, 89, 56, 61, 99
  Operation: new = old * 7
  Test: divisible by 5
    If true: throw to monkey 1
    If false: throw to monkey 5

Monkey 3:
  Starting items: 97, 74, 68
  Operation: new = old + 1
  Test: divisible by 17
    If true: throw to monkey 2
    If false: throw to monkey 5

Monkey 4:
  Starting items: 78, 73
  Operation: new = old + 3
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 5:
  Starting items: 50
  Operation: new = old + 5
  Test: divisible by 7
    If true: throw to monkey 1
    If false: throw to monkey 6

Monkey 6:
  Starting items: 95, 88, 53, 75
  Operation: new = old + 8
  Test: divisible by 3
    If true: throw to monkey 0
    If false: throw to monkey 7

Monkey 7:
  Starting items: 50, 77, 98, 85, 94, 56, 89
  Operation: new = old + 2
  Test: divisible by 13
    If true: throw to monkey 4
    If false: throw to monkey 0
"""
