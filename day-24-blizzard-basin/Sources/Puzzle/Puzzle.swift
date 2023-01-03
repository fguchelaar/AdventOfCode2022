import AdventKit
import Collections
import Foundation

struct Blizzard: Hashable {
    var position: Point
    var direction: Character

    func move(in rect: CGRect) -> Blizzard {
        switch direction {
        case "^":
            return Blizzard(position: Point(x: position.x, y: position.y > Int(rect.origin.y) ? (position.y - 1) : Int(rect.size.height)), direction: direction)
        case "v":
            return Blizzard(position: Point(x: position.x, y: position.y < Int(rect.size.height) ? (position.y + 1) : Int(rect.origin.y)), direction: direction)
        case "<":
            return Blizzard(position: Point(x: position.x > Int(rect.origin.x) ? (position.x - 1) : Int(rect.size.width), y: position.y), direction: direction)
        case ">":
            return Blizzard(position: Point(x: position.x < Int(rect.size.width) ? (position.x + 1) : Int(rect.origin.x), y: position.y), direction: direction)
        default:
            fatalError("unknown direction")
        }
    }
}

struct MinLoc: Hashable {
    var minute: Int
    var position: Point
}

class Puzzle {
    let start: Point
    let goal: Point
    var states = [Int: Set<Blizzard>]()

    let width: Int
    let height: Int

    init(input: String) {
        let lines = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)

        let height = lines.count - 2
        let width = lines[0].count - 2

        var blizzards = Set<Blizzard>()
        lines.enumerated().forEach { line in
            if line.offset > 0 && line.offset <= height {
                line.element.enumerated().forEach { column in
                    if column.offset > 0 && column.offset <= width {
                        if column.element != "." {
                            blizzards.insert(Blizzard(position: Point(x: column.offset, y: line.offset), direction: column.element))
                        }
                    }
                }
            }
        }
        states[0] = blizzards
        let rect = CGRect(origin: CGPoint(x: 1, y: 1), size: CGSize(width: Double(width), height: Double(height)))
        for minute in 1 ..< lcm(width, height) {
            states[minute] = Set(states[minute - 1]!.map { $0.move(in: rect) })
        }

        start = Point(x: lines[0].firstIndex(of: ".")!.utf16Offset(in: lines[0]), y: 0)
        goal = Point(x: lines[height + 1].firstIndex(of: ".")!.utf16Offset(in: lines[height + 1]), y: height + 1)

        self.width = width
        self.height = height
    }

    func distance(from begin: Point, to end: Point, startingAt minute: Int) -> Int {
        var explored = Set<MinLoc>([MinLoc(minute: minute, position: begin)])
        var queue = Deque<MinLoc>([MinLoc(minute: minute, position: begin)])
        var graph = [MinLoc: MinLoc]()

        // prefill all occupied points for every minute
        let blizzards = states.reduce(into: [Int: Set<Point>]()) { map, element in
            map[element.key] = Set(element.value.map { $0.position })
        }

        while !queue.isEmpty {
            let node = queue.removeFirst()

            if node.position == end {
                return node.minute - minute
            }

            let nextMinute = node.minute + 1
            let neighbors = Set(
                node.position.n4.filter {
                    $0 == end || ($0.x > 0 && $0.x <= width && $0.y > 0 && $0.y <= height)
                }
                    + [node.position] // so we can wait
            )
            .filter { !blizzards[nextMinute % lcm(width, height)]!.contains($0) }
            .map { MinLoc(minute: nextMinute, position: $0) }

            for edge in neighbors {
                if explored.insert(edge).inserted {
                    graph[edge] = node
                    queue.append(edge)
                }
            }
        }
        print("didn't find it.. somethings wrong")
        print(explored)
        return -1
    }

    func part1() -> Int {
        distance(from: start, to: goal, startingAt: 0)
    }

    func part2() -> Int {
        let t1 = distance(from: start, to: goal, startingAt: 0)
        let t2 = distance(from: goal, to: start, startingAt: t1)
        let t3 = distance(from: start, to: goal, startingAt: t1 + t2)
        return t1 + t2 + t3
    }
}
