import AdventKit
import Algorithms
import Collections
import Foundation

enum Instruction {
    case walk(distance: Int)
    case turn(direction: Character)
}

class Puzzle {
    let right = 0
    let down = 1
    let left = 2
    let up = 3
    
    let tiles: Set<Point>
    let walls: Set<Point>
    let instructions: Deque<Instruction>
    
    let faceSize: Int
    
    let directions = [
        Point(x: 1, y: 0, invertY: true),
        Point(x: 0, y: 1, invertY: true),
        Point(x: -1, y: 0, invertY: true),
        Point(x: 0, y: -1, invertY: true)
    ]
    
    init(input: String) {
        let parts = input.components(separatedBy: "\n\n")
        
        // Parse the map
        var _tiles = Set<Point>()
        var _walls = Set<Point>()
        
        let map = parts[0]
        let lines = map.components(separatedBy: .newlines)
        lines.enumerated().forEach { line in
            line.element.enumerated().forEach { column in
                if column.element == "." {
                    _tiles.insert(Point(x: column.offset, y: line.offset, invertY: true))
                } else if column.element == "#" {
                    _walls.insert(Point(x: column.offset, y: line.offset, invertY: true))
                }
            }
        }
        tiles = _tiles
        walls = _walls
        faceSize = Int(sqrt(Double((_tiles.count + _walls.count) / 6)))
        
        // Parse _the path you must follow_
        var _instructions = Deque<Instruction>()
        
        var path = parts[1].trimmingCharacters(in: .whitespacesAndNewlines)
        var buffer = ""
        while path != "" {
            let c = path.removeFirst()
            if c.isNumber {
                buffer.append(c)
            } else {
                if !buffer.isEmpty {
                    _instructions.append(.walk(distance: Int(buffer)!))
                    buffer = ""
                }
                _instructions.append(.turn(direction: c))
            }
        }
        if !buffer.isEmpty {
            _instructions.append(.walk(distance: Int(buffer)!))
            buffer = ""
        }
        instructions = _instructions
    }
    
    func targetPosition(from position: Point, with direction: Point) -> Point? {
        var proposal = position + direction
        if tiles.contains(proposal) {
            return proposal
        } else if walls.contains(proposal) {
            return nil
        }
        let allPoints = tiles.union(walls)
        if direction == directions[0] { // right
            proposal = allPoints.filter { $0.y == position.y }.sorted { $0.x < $1.x }.first!
        } else if direction == directions[1] { // down
            proposal = allPoints.filter { $0.x == position.x }.sorted { $0.y < $1.y }.first!
        } else if direction == directions[2] { // left
            proposal = allPoints.filter { $0.y == position.y }.sorted { $0.x < $1.x }.last!
        } else if direction == directions[3] { // up
            proposal = allPoints.filter { $0.x == position.x }.sorted { $0.y < $1.y }.last!
        }
        
        // circle around
        return tiles.contains(proposal) ? proposal : nil
    }

    func solve() -> Int {
        var position = tiles.filter { $0.y == 0 }.sorted { $0.x < $1.x }.first!
        var directionIndex = 0

        for instruction in instructions {
            switch instruction {
            case .turn(let direction):
                if direction == "R" {
                    directionIndex = (directionIndex + 1) % 4
                } else {
                    directionIndex = (directionIndex - 1 + 4) % 4
                }
            case .walk(let distance):
                for _ in 0 ..< distance {
                    if let target = targetPosition(from: position, with: directions[directionIndex]) {
                        position = target
                    } else {
                        break
                    }
                }
            }
        }
        
        return (position.y + 1) * 1000
            + (position.x + 1) * 4
            + directionIndex
    }
    
    func part1() -> Int {
        solve()
    }
    
    func targetPosition2(from position: Point, with directionIndex: Int) -> (Point, Int)? {
        let direction = directions[directionIndex]
        var proposal = position + direction
        var newDirection = directionIndex
        if tiles.contains(proposal) {
            return (proposal, newDirection)
        } else if walls.contains(proposal) {
            return nil
        }
        
        // ⚠️ hardcoded the layout of the cubes
        
        // The map is divided in segments
        //
        // Real input       Test input
        //
        // |---|---|---|    |---|---|---|---|
        // |   | 1 | 2 |    |   |   | 1 |   |
        // |---|---|---|    |---|---|---|---|
        // |   | 3 |   |    | 2 | 3 | 4 |   |
        // |---|---|---|    |---|---|---|---|
        // | 4 | 5 |   |    |   |   | 5 | 6 |
        // |---|---|---|    |---|---|---|---|
        // | 6 |   |   |
        // |---|---|---|
        
        let segment = Point(x: position.x / faceSize, y: position.y / faceSize)
        let modx = position.x % faceSize
        let mody = position.y % faceSize
        
        if faceSize == 4 { // we're in unittest-mode
            switch segment {
            case Point(x: 2, y: 0): // #1
                if direction == directions[0] { // right -> 6
                    proposal = Point(x: faceSize * 4 - 1, y: (faceSize * 3 - 1) - mody)
                    newDirection = 2 // left
                } else if direction == directions[2] { // left -> 3
                    proposal = Point(x: faceSize + mody, y: faceSize)
                    newDirection = 1 // down
                } else if direction == directions[3] { // up -> 2
                    proposal = Point(x: (faceSize - 1) - modx, y: faceSize)
                    newDirection = 1 // down
                }
            case Point(x: 0, y: 1): // #2
                if direction == directions[1] { // down -> 5
                    proposal = Point(x: (faceSize * 3 - 1) - modx, y: faceSize * 3 - 1)
                    newDirection = 3 // up
                } else if direction == directions[2] { // left -> 6
                    proposal = Point(x: (faceSize * 4 - 1) - mody, y: faceSize * 3 - 1)
                    newDirection = 3 // up
                } else if direction == directions[3] { // up -> 2
                    proposal = Point(x: (faceSize * 3 - 1) - modx, y: 0)
                    newDirection = 1 // down
                }
            case Point(x: 1, y: 1): // #3
                if direction == directions[1] { // down -> 5
                    proposal = Point(x: faceSize * 2, y: (faceSize * 3 - 1) - modx)
                    newDirection = 0 // right
                } else if direction == directions[3] { // up -> 1
                    proposal = Point(x: faceSize * 2, y: modx)
                    newDirection = 0 // right
                }
            case Point(x: 2, y: 1): // #4
                if direction == directions[0] { // right -> 6
                    proposal = Point(x: (faceSize * 4 - 1) - mody, y: faceSize * 2)
                    newDirection = 1 // down
                }
            case Point(x: 2, y: 2): // #5
                if direction == directions[1] { // down -> 2
                    proposal = Point(x: (faceSize - 1) - modx, y: faceSize * 2 - 1)
                    newDirection = 3 // up
                } else if direction == directions[2] { // left -> 3
                    proposal = Point(x: (faceSize * 2 - 1) - modx, y: faceSize * 2 - 1)
                    newDirection = 3 // up
                }
            case Point(x: 3, y: 2): // #6
                if direction == directions[0] { // right -> 1
                    proposal = Point(x: faceSize * 3 - 1, y: (faceSize - 1) - mody)
                    newDirection = 2 // left
                } else if direction == directions[1] { // down -> 2
                    proposal = Point(x: 0, y: (faceSize * 2 - 1) - modx)
                    newDirection = 0 // right
                } else if direction == directions[3] { // up -> 4
                    proposal = Point(x: faceSize * 3 - 1, y: (faceSize * 2 - 1) - modx)
                    newDirection = 2 // left
                }
            default: fatalError("we're on a non-existing face of the cube...")
            }
        } else { // real-input mode
            switch segment {
            case Point(x: 1, y: 0): // #1
                if directionIndex == left { // 4
                    proposal = Point(x: 0, y: (faceSize * 3 - 1) - mody)
                    newDirection = right
                } else if directionIndex == up { // 6
                    proposal = Point(x: 0, y: faceSize * 3 + modx)
                    newDirection = right
                }
            case Point(x: 2, y: 0): // #2
                if directionIndex == right { // 5
                    proposal = Point(x: faceSize * 2 - 1, y: (faceSize * 3 - 1) - mody)
                    newDirection = left
                } else if directionIndex == down { // 3
                    proposal = Point(x: faceSize * 2 - 1, y: faceSize + modx)
                    newDirection = left
                } else if directionIndex == up { // 6
                    proposal = Point(x: modx, y: faceSize * 4 - 1)
                    newDirection = up
                }
            case Point(x: 1, y: 1): // #3
                if directionIndex == right { // 2
                    proposal = Point(x: faceSize * 2 + mody, y: faceSize - 1)
                    newDirection = up
                } else if directionIndex == left { // 4
                    proposal = Point(x: mody, y: faceSize * 2)
                    newDirection = down
                }
            case Point(x: 0, y: 2): // #4
                if directionIndex == left { // 1
                    proposal = Point(x: faceSize, y: (faceSize - 1) - mody)
                    newDirection = right
                } else if directionIndex == up { // 3
                    proposal = Point(x: faceSize, y: faceSize + modx)
                    newDirection = right
                }
            case Point(x: 1, y: 2): // #5
                if directionIndex == right { // 2
                    proposal = Point(x: faceSize * 3 - 1, y: (faceSize - 1) - mody)
                    newDirection = left
                } else if directionIndex == down { // 6
                    proposal = Point(x: faceSize - 1, y: faceSize * 3 + modx)
                    newDirection = left
                }
            case Point(x: 0, y: 3): // #6
                if directionIndex == right { // 5
                    proposal = Point(x: faceSize + mody, y: faceSize * 3 - 1)
                    newDirection = up
                } else if directionIndex == down { // 2
                    proposal = Point(x: (faceSize * 2) + modx, y: 0)
                    newDirection = down
                } else if directionIndex == left { // 1
                    proposal = Point(x: faceSize + mody, y: 0)
                    newDirection = down
                }
            default: fatalError("we're on a non-existing face of the cube...")
            }
        }
        
        // circle around
        return tiles.contains(proposal) ? (proposal, newDirection) : nil
    }
    
    func part2() -> Int {
        var position = tiles.filter { $0.y == 0 }.sorted { $0.x < $1.x }.first!
        var directionIndex = 0

        for instruction in instructions {
            switch instruction {
            case .turn(let direction):
                if direction == "R" {
                    directionIndex = (directionIndex + 1) % 4
                } else {
                    directionIndex = (directionIndex - 1 + 4) % 4
                }
            case .walk(let distance):
                for _ in 0 ..< distance {
                    if let target = targetPosition2(from: position, with: directionIndex) {
                        position = target.0
                        directionIndex = target.1
                    } else {
                        break
                    }
                }
            }
        }
        
        return (position.y + 1) * 1000
            + (position.x + 1) * 4
            + directionIndex
    }
}
