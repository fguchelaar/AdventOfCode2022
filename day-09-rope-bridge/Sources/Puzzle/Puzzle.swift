import AdventKit
import Foundation

class Puzzle {
    let motions: [String]

    init(input: String) {
        self.motions = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
    }

    func createRope(of length: Int) -> (head: Knot, tail: Knot) {
        let head = Knot()
        var last = head

        (0 ..< length).forEach { _ in
            let next = Knot()
            next.head = last
            last.tail = next
            last = next
        }
        return (head, last)
    }
    
    func solve(forTailLength length: Int) -> Int {
        var positions = Set<Point>()
        let rope = createRope(of: length)
        
        for motion in motions {
            let steps = Int(motion.split(separator: " ")[1])!
            let direction = motion.split(separator: " ")[0]

            for _ in 0 ..< steps {
                rope.head.move(direction: direction)
                positions.insert(rope.tail.position)
            }
        }
        return positions.count
    }
    
    func part1() -> Int {
        solve(forTailLength: 1)
    }

    func part2() -> Int {
        solve(forTailLength: 9)
    }
}
