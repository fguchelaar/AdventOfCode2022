import AdventKit
import Algorithms
import Foundation

class Puzzle {
    let input: String

    init(input: String) {
        self.input = input
    }

    func part1() -> Int {
        let numbers = initialize()
        mix(numbers: numbers)
        return sumOfGrove(in: numbers)
    }

    func part2() -> Int {
        let numbers = initialize(multiplier: 811589153)
        mix(numbers: numbers, count: 10)
        return sumOfGrove(in: numbers)
    }

    func initialize(multiplier: Int = 1) -> [Node<Int>] {
        let numbers = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .compactMap(Int.init)
            .map { Node(element: $0 * multiplier) }

        // attach all nodes
        numbers.first!.previous = numbers.last!
        numbers.last!.next = numbers.first!

        // make 'windows'? and attach all prev en next variables
        numbers.adjacentPairs().forEach {
            $0.0.next = $0.1
            $0.1.previous = $0.0
        }

        return numbers
    }

    func mix(numbers: [Node<Int>], count: Int = 1) {
        for _ in 0 ..< count {
            for number in numbers {
                let steps = number.element % (numbers.count - 1)
                if steps == 0 {
                    continue
                }

                number.previous!.next = number.next
                number.next!.previous = number.previous

                var target = number.previous

                if steps > 0 {
                    for _ in 0 ..< steps {
                        target = target!.next
                    }
                } else {
                    for _ in steps ..< 0 {
                        target = target!.previous
                    }
                }

                number.previous = target
                number.next = target!.next

                target!.next = number
                number.next?.previous = number
            }
        }
    }

    func sumOfGrove(in numbers: [Node<Int>]) -> Int {
        let number0 = numbers.first { $0.element == 0 }!

        var number1000 = number0
        for _ in 0 ..< 1000 {
            number1000 = number1000.next!
        }
        var number2000 = number1000
        for _ in 0 ..< 1000 {
            number2000 = number2000.next!
        }
        var number3000 = number2000
        for _ in 0 ..< 1000 {
            number3000 = number3000.next!
        }

        return number1000.element
            + number2000.element
            + number3000.element
    }
}
