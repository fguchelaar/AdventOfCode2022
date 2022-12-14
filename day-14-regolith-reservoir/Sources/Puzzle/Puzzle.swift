import AdventKit
import Algorithms
import Foundation

class Puzzle {
    // a set filled with all Points of the rocks
    let rocks: Set<Point>
    // the y-position of the lowest rock
    let bottom: Int

    init(input: String) {
        var _rocks = Set<Point>()
        var _bottom = Int.min

        let lines = input.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
        for line in lines {
            let vectors = line.components(separatedBy: " -> ")
            let pairs = vectors.adjacentPairs()
            for pair in pairs {
                let p1 = Point(string: pair.0, invertY: true)!
                let p2 = Point(string: pair.1, invertY: true)!

                let minX = min(p1.x, p2.x)
                let maxX = max(p1.x, p2.x)
                let minY = min(p1.y, p2.y)
                let maxY = max(p1.y, p2.y)
                _bottom = max(_bottom, maxY)
                for xy in product(minX...maxX, minY...maxY) {
                    _rocks.insert(Point(x: xy.0, y: xy.1, invertY: true))
                }
            }
        }
        rocks = _rocks
        bottom = _bottom
    }

    func part1() -> Int {
        // Mutable copy of the rocks, so we can add water
        var cave = rocks

        let source = Point(x: 500, y: 0, invertY: true)

        var location = source
        repeat {
            if !cave.contains(location.down) {
                location = location.down
            } else if !cave.contains(location.down.left) {
                location = location.down.left
            } else if !cave.contains(location.down.right) {
                location = location.down.right
            } else {
                // we found a place to settle down
                cave.insert(location)
                location = source
            }
        } while location.y < bottom

        return cave.count - rocks.count
    }

    func part2() -> Int {
        // Mutable copy of the rocks, so we can add water
        var cave = rocks

        let floor = bottom + 2
        let source = Point(x: 500, y: 0, invertY: true)

        var location = source
        while true {
            if location.y + 1 < floor && !cave.contains(location.down) {
                location = location.down
            } else if location.y + 1 < floor && !cave.contains(location.down.left) {
                location = location.down.left
            } else if location.y + 1 < floor && !cave.contains(location.down.right) {
                location = location.down.right
            } else {
                // we found a place to settle down
                cave.insert(location)

                // did we put in the starting location
                if location == source {
                    break
                }
                location = source
            }
        }

        return cave.count - rocks.count
    }
}
