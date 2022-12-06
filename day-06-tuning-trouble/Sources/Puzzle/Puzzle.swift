import AdventKit
import Foundation

class Puzzle {
    let input: [Character]

    init(input: String) {
        self.input = Array(input)
    }

    func part1() -> Int {
        findIndex(with: 4)
    }

    func part2() -> Int {
        findIndex(with: 14)
    }

    func findIndex(with count: Int) -> Int {
        (count ..< input.count).first { i in
            Set(input[i - count ..< i]).count == count
        } ?? -1
    }
}
