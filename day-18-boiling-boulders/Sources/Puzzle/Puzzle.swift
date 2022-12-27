import AdventKit
import Algorithms
import Collections
import Foundation

class Puzzle {
    let positions: Set<Point3d>

    init(input: String) {
        self.positions = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map { line in
                let parts = line.components(separatedBy: ",").compactMap(Int.init)
                return Point3d(x: parts[0], y: parts[1], z: parts[2])
            }
            .reduce(into: Set<Point3d>()) {
                $0.insert($1)
            }
    }

    func part1() -> Int {
        positions.map { point in
            6-positions.intersection(point.n6).count
        }.reduce(0,+)
    }

    func part2() -> Int {
        // find extremeties of the cube and create a 'bounding box'
        let minAndMaxX = positions.map { $0.x }.minAndMax()!
        let minAndMaxY = positions.map { $0.y }.minAndMax()!
        let minAndMaxZ = positions.map { $0.z }.minAndMax()!

        var boundingBox = Set<Point3d>()
        for x in minAndMaxX.min-1...minAndMaxX.max+1 {
            for y in minAndMaxY.min-1...minAndMaxY.max+1 {
                for z in minAndMaxZ.min-1...minAndMaxZ.max+1 {
                    boundingBox.insert(Point3d(x: x, y: y, z: z))
                }
            }
        }

        // do a flood-fill from a point in the void
        let start = Point3d(x: minAndMaxX.min-1, y: minAndMaxY.min-1, z: minAndMaxZ.min-1)
        var queue = Deque<Point3d>([start])
        var explored = Set<Point3d>([start])

        while !queue.isEmpty {
            let node = queue.removeFirst()

            for neighbor in node.n6.filter({ p in boundingBox.contains(p) && !positions.contains(p) }) {
                if !explored.contains(neighbor) {
                    explored.insert(neighbor)
                    queue.append(neighbor)
                }
            }
        }

        // the remaining cubes make up a solid shape, calculate edges
        let solidShape = boundingBox.subtracting(explored)
        
        return solidShape.map { point in
            6-solidShape.intersection(point.n6).count
        }.reduce(0,+)
    }
}
