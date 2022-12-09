import AdventKit
import Foundation

class Knot {
    var head: Knot?
    var tail: Knot?
    var position = Point.zero

    func move(direction: Substring) {
        switch direction {
        case "U":
            position = position.up
        case "R":
            position = position.right
        case "D":
            position = position.down
        case "L":
            position = position.left
        default:
            break
        }
        tail?.keepUp()
    }

    private func keepUp() {
        guard let head = head else {
            return
        }

        // are we touching?
        if (head.position.n8 + [head.position]).contains(position) {
            return
        }

        if head.position.x == position.x {
            position = position + Point(x: 0, y: head.position.y > position.y ? 1 : -1)
        } else if head.position.y == position.y {
            position = position + Point(x: head.position.x > position.x ? 1 : -1, y: 0)
        } else {
            position = position + Point(x: head.position.x > position.x ? 1 : -1, y: head.position.y > position.y ? 1 : -1)
        }

        tail?.keepUp()
    }
}
