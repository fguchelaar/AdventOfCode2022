import AdventKit
import Foundation

class Puzzle {
    let input: [[Int]]
    
    init(input: String) {
        self.input = input.components(separatedBy: "\n\n")
            .map { $0.components(separatedBy: "\n").compactMap(Int.init) }
    }
    
    func part1() -> Int {
        input
            .map { $0.reduce(0, +) }
            .max()!
    }
    
    func part2() -> Int {
        input
            .map { $0.reduce(0, +) }
            .sorted()
            .suffix(3)
            .reduce(0, +)
    }
}
