import AdventKit
import Foundation

class Puzzle {
    let forest: [[Int]]

    init(input: String) {
        forest = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map { $0.compactMap(Int.init) }
    }

    func part1() -> Int {
        var total = 0

        for y in 0..<forest.count {
            for x in 0..<forest[0].count {
                if fromLeft(x: x, y: y)
                    || fromRight(x: x, y: y)
                    || fromTop(x: x, y: y)
                    || fromBottom(x: x, y: y)
                {
                    total += 1
                }
            }
        }

        return total
    }

    func fromLeft(x: Int, y: Int) -> Bool {
        for _x in 0..<x {
            if forest[y][_x] >= forest[y][x] {
                return false
            }
        }
        return true
    }

    func fromRight(x: Int, y: Int) -> Bool {
        for _x in x+1..<forest[0].count {
            if forest[y][_x] >= forest[y][x] {
                return false
            }
        }
        return true
    }

    func fromTop(x: Int, y: Int) -> Bool {
        for _y in 0..<y {
            if forest[_y][x] >= forest[y][x] {
                return false
            }
        }
        return true
    }

    func fromBottom(x: Int, y: Int) -> Bool {
        for _y in y+1..<forest.count {
            if forest[_y][x] >= forest[y][x] {
                return false
            }
        }
        return true
    }

    func part2() -> Int {
        var maxScore = 0

        for y in 0..<forest.count {
            for x in 0..<forest[0].count {
                maxScore = max(maxScore, countLeft(x: x, y: y)
                    * countRight(x: x, y: y)
                    * countUp(x: x, y: y)
                    * countDown(x: x, y: y))
            }
        }

        return maxScore
    }

    func countLeft(x: Int, y: Int) -> Int {
        for _x in stride(from: x - 1, through: 0, by: -1) {
            if forest[y][_x] >= forest[y][x] {
                return x - _x
            }
        }
        return x
    }

    func countRight(x: Int, y: Int) -> Int {
        for _x in x+1..<forest[0].count {
            if forest[y][_x] >= forest[y][x] {
                return _x - x
            }
        }
        return forest[0].count - x - 1
    }

    func countUp(x: Int, y: Int) -> Int {
        for _y in stride(from: y - 1, through: 0, by: -1) {
            if forest[_y][x] >= forest[y][x] {
                return y - _y
            }
        }
        return y
    }

    func countDown(x: Int, y: Int) -> Int {
        for _y in y+1..<forest.count {
            if forest[_y][x] >= forest[y][x] {
                return _y - y
            }
        }
        return forest.count - y - 1
    }
}
