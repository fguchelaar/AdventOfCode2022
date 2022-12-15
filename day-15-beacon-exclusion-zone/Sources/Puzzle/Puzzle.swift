import AdventKit
import Algorithms
import Collections
import Foundation

struct Pair {
    let sensor: Point
    let beacon: Point
    let distance: Int

    init(sensor: Point, beacon: Point) {
        self.sensor = sensor
        self.beacon = beacon
        distance = sensor.manhattan(to: beacon)
    }
}

struct Range {
    let lowerBound: Int
    let upperBound: Int
}

class Puzzle {
    let pairs: [Pair]

    init(input: String) {
        pairs = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map {
                let tokens = $0.components(separatedBy: CharacterSet(charactersIn: " =,:"))
                    .compactMap(Int.init)

                return Pair(sensor: Point(x: tokens[0], y: tokens[1]),
                            beacon: Point(x: tokens[2], y: tokens[3]))
            }
    }

    func part1(row target: Int) -> Int {
        // assumption: the result is one contiguous line 🤞

        var minx = Int.max
        var maxx = Int.min

        for pair in pairs {
            let d1 = pair.distance // total distance from sensor to beacon
            let d2 = abs(pair.sensor.y - target) // distance from sensor to 'scanline'
            if d2 > d1 { // is the line not within reach of the sensor?
                continue
            }
            let d3 = abs(d2 - d1) // horizontal reach, after travelling vertically to the scanline
            let mx1 = pair.sensor.x - d3
            let mx2 = pair.sensor.x + d3

            minx = min(minx, mx1) // find the outer left value
            maxx = max(maxx, mx2) // find the outer right value
        }

        return maxx - minx
    }

    func merge(_ ranges: Deque<Range>) -> Deque<Range> {
        var sorted = ranges.sorted { $0.lowerBound < $1.lowerBound }
        var result = Deque<Range>()
        result.append(sorted.removeFirst())

        while !sorted.isEmpty {
            let a = result.last!
            let b = sorted.removeFirst()
            let merged = merge(a: a, b: b)

            if merged.count == 1 {
                result.removeLast()
                result.append(merged[0])
            } else {
                result.append(b)
            }
        }
        return result
    }

    /// Merges two ranges when they overlap, or are adjacent. Adjacency-check only works if a & b are sorted ascending.
    func merge(a: Range, b: Range) -> [Range] {
        if b.lowerBound <= a.upperBound {
            return [Range(lowerBound: min(a.lowerBound, b.lowerBound), upperBound: max(a.upperBound, b.upperBound))]
        } else {
            return [a, b]
        }
    }

    func part2(boundary: Int) -> Int {
        let lowerY = max(0, pairs.map { $0.sensor.y - $0.distance }.min()!)
        let upperY = min(boundary, pairs.map { $0.sensor.y + $0.distance }.max()!)
        var ranges = Deque<Range>()
        for y in lowerY ... upperY {

            for pair in pairs {
                let d1 = pair.distance // total distance from sensor to beacon
                let d2 = abs(pair.sensor.y - y) // distance from sensor to 'scanline'
                if d2 > d1 { // is the line not within reach of the sensor?
                    continue
                }
                let d3 = abs(d2 - d1) // horizontal reach, after travelling vertically to the scanline
                let mx1 = pair.sensor.x - d3
                let mx2 = pair.sensor.x + d3

                ranges.append(Range(lowerBound: mx1, upperBound: mx2))
            }

            let merged = merge(ranges)
            if merged.count != 1 {
                return (merged.first!.upperBound + 1) * 4_000_000 + y
            }
            ranges.removeAll(keepingCapacity: true) // speeds up the solution by ~ 1 sec
        }

        return -1
    }
}
