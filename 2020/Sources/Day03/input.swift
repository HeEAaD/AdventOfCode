let sampleInput = """
..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#
"""

let input = """
..#..#......###.#...#......#..#
...#.....#...#...#..........#..
....#.#...............#.#.#....
.........#.......##............
#.#....#.#####.##.#........#..#
.....#...##.#..#.##...#.#..#...
#.#..###.#........#....##...#.#
..###.....#..###.....##........
#.#.#...........#.....#.#....##
...#.#.##.##.#.#......#...##.#.
.....##.#..#....#..#...##...###
...#.....#..#..#...#.#....##...
.#...##.#.........#...#.#......
....#...#.....#......#...#.....
.#...#.....#....#......#...#...
#...#......####..##...###......
....#..#......##.##.....#..#...
....#....#.......#..#...#....#.
...##..#.##..#.#...#..##.......
##.#..#.....#.##.#....#..##....
#....#....#.....#..#.#.#.....#.
##...#.###.....#....#..#.#.#...
#..#.......#...#.#...#.#.....#.
....#.#.......#.....###..#..#.#
......####...#.#..#..#.#.#.#...
#...##.....#...#.#.........#.#.
......#...##.#..#.#........#...
..#.#...........#..##...###.##.
#......#.#......#.....#.....#.#
.#...............###.#.###.....
...#...........##..#...##..##.#
#......#.##.#............#.##.#
.#.#....#....###........#..#...
...##.#.#..#.##.#..##..#.##..##
.....#...#.#.#...#....#......#.
..............#...##...........
..............##........#..###.
.#.##.......#.....##.#......#..
..#......#..#.#####..#.#.......
#.#..#...#.#..#....#..#.##..#..
...##.......#.#............#...
...#....#..#.##.###.......#.###
..###..#....#..#.....##...#..#.
..#.###.##......###....#....##.
...#...##...###....##.....###.#
.....#.....#.#.#.........#..###
#.#......#.#..#.####..#........
#....#.##.......##.............
..##...........#....#.....##..#
..#...#...........#....#...#...
...#...#...#.....#..#....#....#
#......##.........#.#...##...#.
.##..#...#.....#....#.##.####.#
#..##.##.#......#.............#
.#.....#..##.###.#.#.#.........
.###....###..#....#..#.#.#..##.
....#........#..#....##..#.#.#.
.....#..........#..........#...
.#.##..#..#...#..#.##.#.##.....
.#....#...#......#.#..##.##..#.
.###.#...#.#.##....#.....#..##.
......##.......#..#.......#.#.#
.##.#.#.#......#.......#.......
#..#...##......#.......#......#
...#..#...##.#...#..##.........
.....#..###...##...#..#.#...#.#
..#.#.#....##..#.#.#.#...#.....
.....#.#.#..#..#.#.#...#.......
#.#.#...#.#.....#.#.#.##.###...
.....#.#.....####..#...........
..#.#.#...........##..#.#....#.
.#..#......#..#...........###..
..#...###.##......#..###...#..#
#.#..#.....#..#.##.#..#.#.....#
.....................#.#..#....
...##..##...#.#..#..##.#....#..
.#..#.#....#...#.#.##..........
....##.....#..#..##.........##.
..##...##........#.#....#...###
.#...#............#.#.#.#......
#...#........#..#..#...#.#.....
..#..........#.......###.##....
#...........###..#....##..#.##.
##...#..#.##.....#...........#.
.#..##.....#..#.#.....##.#..#.#
..#..#.##....#.........#.#.#...
#..#...#...#..#...........##...
.....#.......#.#......#.#.#...#
..#.#..#..#.#.#.......#.#...#..
......#.....##.....#.....##.##.
#.#..#......#......#.####.##...
.####...#####.#....#.#..##.....
............#....#....#....##..
###.........#............#.#...
...#...#....#.##..#...#......##
...##.#.#.##.##.#.....#...#.#..
...#.....#...#..##......#.#.##.
.##.#......##................##
......#.....#..##.............#
#.#...##..#..#..#.##.....#..#..
#......###.....#....##...##...#
....#..#.....#.......####...##.
#.#...#.#...#..........#..##..#
....#..#....#................##
.####..#........#..#.#...#.....
##.###...#.##........#..##.....
..###..##...#...#..#...##.....#
......#..##....................
.#...#......#.#.##..#........#.
..#...#####.....##.....#...#...
.#..#....#..#....##.#....#..##.
.#.....##..###.#.....#.#.#.##..
#..##.....##...#.....#..#.#....
#.##......#.#......#..........#
#####........#.............#...
.#..#..##..#....#.....#..####..
...#..##.##...####....#.##...##
..........#....#...........##.#
#...##...#...##....#.....#.....
.......#..#.....#.#.#.#.#.....#
...#..##..####..#..##.#.##....#
#...#...#...........#.#.....#.#
..#.....##...###.........#..##.
.......##..#.......#.......##..
#.#....#....#.###............#.
...#......#.#.............#.#..
......#..#....#....#....#..#...
.....##..#...........##...#.##.
..#....#.##.#......#...........
#...#....#.#.#.#.#..#..........
.#..#..........#..#.#.....#....
.....##......##....#.#.....#.#.
.....#..#..........#....#.....#
....#..#..#.#...#.#..#..#..##.#
.#..##.#..##...###.#..........#
..###..#......#...##...#.#.....
..#...#...#.....#.......#....#.
#...##..#.##.#....##.....#.....
..#.#.....#...#...#............
.......#.#.#..#.....###.#...##.
....##.......#####...##..##..#.
#...#.##.....#.#...##.........#
..#.##..........#..###.#....#..
#......#.##...#...#.....###....
................#.##...........
##.###.#.#.#.##......##..#....#
..#.#........##..#..##.........
###....#..#....#..##....#.....#
#......#..#...........#.#...##.
...###.......#...#......##..#.#
.......#...##.#.#...#.##......#
......##..#...##.#.#...##....#.
..#...#...#...#.#.....#..##..#.
..##...#.....#.....#..##.......
....#........#.#.##.......#.#..
#...#..##..#..##..#...#......#.
...#..#.#.#..#..#..####...#....
#..#..#......#......#..#.######
#..#..#..#........#..#.#....###
#..##..#.#.##.....#..#......#.#
##.......##.#..#.............#.
..........#.#..#..#............
....#.#.#.#...#......#......#..
###.#.#.........#.......#...##.
#.............####..#...#.##...
....##.......#................#
###...#..#......##....#.####.#.
..##.##.#.#.#.#...#.......#...#
.....#.##......#.......##..#.#.
.#...#.##..#.......#.#....#.#.#
##...##..#....#..#...#....#....
..........#...##.#..##.......##
#.#...#....#......#.#.......###
......#...#.##....#....##.#.##.
..#..#.......#.......#....##...
##..##.......##............#.#.
.#.#...#..#.#.###......#.......
#...#..##....#...###..#.#.....#
.#.....#........#..##.#.#.#....
..#.##....#..#...........#...#.
.....#.#...#.##..###...#...#...
#....####.......#..#.#...#.....
....#.....#....##..#.##.....###
........#.#.....###....#.#.....
...#.....#.##.....#......#.....
.....#...####......###..#...##.
#.#......#..........#..##.#..#.
..##......###...#...#.......#..
#...#.#...#.#.........#........
....#..#.##.#.##.###..#.....#..
.#.#.#......#.#........#.....#.
.....#.#..#....#...#.....#.#.##
##.............#..#.....#.#....
#............#..#....##......##
#....#......#......#....##..#..
.#....#............#......##..#
..#.#.#..#.#....##.#.......#.##
#.##.....#...#......#...#......
.......#...........#..#.##..#.#
##.....##.#.....####..........#
...#.......#.#.............#..#
...##........##..#..#.#........
.#.##...#.....##.#......#....#.
.#................#.#...#..#...
#....#.#.#......#.#.#.##....#..
..#......#............#...#....
###..#.##........#....##.#...#.
.#..#..#......##...............
....##.............#....##...##
..#.#..#.#####....##.......###.
......#...#..#.#....#.#..#...#.
.........#..##.##...#....##..##
.............#.##....###.#.....
..#................#..#.#..#...
...#........#......#..###......
.#.#.#....#.........#...###.###
.........#..#.#......##.....#..
#...##..#.#.###..###...........
...#.#.#..#......#..##.#.##....
.....##.......#................
.##....#.#.#.##.....#.##......#
...#........#...##.#.##..##...#
..#..........#.#......####..##.
............#.#.#.#.....#......
..##.####.#..#....#..#..##.....
......#........#...#..#.#..###.
#.#..............#..#...#..#...
....#............#...#..#...##.
..##....#...##.##.#..........##
..#..#.........#..#.....#.#....
#.....#.###...##...##...##.....
#.#...#..#####.#...#..#.....#..
..#.....###...#.........#.#...#
....#.##.........#.#.....#.#.#.
..........##...#....#.#.#.....#
...#...........#.....###.......
#....#..#...#.....#.......#....
.#.#.....#..##..##..#........#.
.#.#.....#....#...#.#.##.......
....###...#...###.##....#......
...#.#.##....#...##......#...#.
#....#...##.....#.##.#.....#.##
.#.#.....##.##.##..###...#.....
.#.#......#..#..#........#.#..#
........#...##........##...#...
.#..#.#.#..#.....#....#...#.#..
#......#...#.#...#..#.#..#.....
.#......#.....#.........###.#..
#..#..........##..###.......#..
#..#..#....#......#......#.....
......#.....##.........##....#.
#..#.#...#...#.##.#..#..##.....
....#.#....###..#.....#...##.#.
..##.....##.#..#..##..#.#......
.........#..#....###...#.#....#
.........#...#...#...#......##.
.......#..#.....#.#.#...#...#..
............#.....###......#..#
#....##..###.......#...##....##
..#.##..#####..##.#...#......#.
#.#..#...###.............#.#...
##...#..#..#.#....#.#.......#..
.....#....##.....###.##..#.....
......##..##..#.#..####.#......
..#...#.#....#...#.#.........#.
##.....#.#....#..#..##........#
...........#..#........##..#...
..##.#...#.#.#..##..#..#..#..##
..........#.###.....#..#.....#.
......#............###..##.##..
.#.......#..#...........#.###.#
#...#..##............##.......#
.###..#...#.#....#....#......#.
..##.........##............#.#.
.##.......##....#.#.#....#..#.#
#.##........#.....#.##...#.#...
#......#....#.#......##....#..#
#.##..##..#...#.###......#.....
..........#.#....###.#.....##..
#..##...#.###..#.............#.
.#.#......#.##.#...#....#.....#
.##...#..##...#...........#.##.
.##..#.#.#..#.....#.....###....
.#...#.#.#..#..#....##...#..#..
#.#.#....#.....#..#..##..#.#...
......#..#...####..#.........#.
.#.#..#......#...#..####.....#.
...#.#...#...#....##..#.#.#.##.
...#........##.............#.#.
...#...#...#.......#..#.#.#..##
.####.#...##......#.##.##.#.#..
#..###...........#..#.#...#.#.#
###...#.#..#...#.#...#.#..#.#.#
#....#.....##...#.#...#..#.#...
.#........##.##....##..#..#....
.#.#.#..#........#...#..#.#.#.#
#.##.....#.#...#....##...#..#.#
..#.......##.#.###............#
##....###..##.........##..#.#..
...##...#...#..###.#.....##..#.
###.................#.#..#.....
....#......#.....#..###......##
.......#...##..#...............
.#.....#..#.....#...##...#...##
.....##....#.#..#.##.....#...#.
#..####.#....#..#.....#....#..#
..#..##.#.##......#..#.#....#..
..#.#.#.#.....#...#...#..#.....
.#........#.#...#.#..#...##....
.#...#.#...#..#.#...###...#.#..
#.....#...##..#.....#...#.#..#.
...#....#................#.#...
......##.#.#..........#...#....
.##..#.#.#...#..#...####.#.....
#......#....#..#.......#.......
.#........#.#.#....###.#..##...
....##......#.....##...#...#...
..#..#.#.#...#..#.####.##......
...#........#.#.##.#..#.##.#...
.#..##...#...#...##.......##.#.
#...#.#......#.................
..#..#.....#....##...#..###....
.#...#.........#.#.##.#........
"""