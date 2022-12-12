import AdventKit
import Collections
import Foundation

class Puzzle {
    let grid: [Point: Character]
    let start: Point!
    let goal: Point!
    
    init(input: String) {
        var _grid = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .enumerated()
            .reduce(into: [Point: Character]()) { map, row in
                row.element.enumerated().forEach { column in
                    map[Point(x: column.offset, y: row.offset)] = column.element
                }
            }
        
        self.start = _grid.first { $0.value == "S" }?.key
        self.goal = _grid.first { $0.value == "E" }?.key
        
        _grid[start] = "a"
        _grid[goal] = "z"
        
        self.grid = _grid
    }
    
    func distance(from start: Point, testFunction: (Point) -> Bool, edgesFunction: (Point) -> [Point]) -> Int? {
        var queue = Deque<Point>([start])
        var explored = Set<Point>([start])
        var distance = [start: 0]
        
        while !queue.isEmpty {
            let node = queue.removeFirst()

            if testFunction(node) {
                return distance[node]!
            }
            for edge in edgesFunction(node) {
                if !explored.contains(edge) {
                    explored.insert(edge)
                    queue.append(edge)
                    distance[edge] = distance[node]! + 1
                }
            }
        }        
        return nil
    }

    
    /// Finds the edges that you can step on to.
    /// > To avoid needing to get out your climbing gear, the elevation of the destination
    /// > square can be at most one higher than the elevation of your current square.
    func edgesUp(for point: Point) -> [Point] {
        let height = grid[point]!.asciiValue!
        return point.n4.filter {
            grid.keys.contains($0) && grid[$0]!.asciiValue! <= height + 1
        }
    }
    
    func part1() -> Int {
        distance(from: start, testFunction: { $0 == goal }, edgesFunction: edgesUp(for:)) ?? -1
    }
    
    /// Finds the edges that you can step down to. Reversed the logic for `edgesUp`
    func edgesDown(for point: Point) -> [Point] {
        let height = grid[point]!.asciiValue!
        return point.n4.filter {
            grid.keys.contains($0) && (grid[$0]!.asciiValue! + 1) >= height
        }
    }

    func part2() -> Int {
        distance(from: goal, testFunction: { grid[$0] == "a" }, edgesFunction: edgesDown(for:)) ?? -1
    }
}
