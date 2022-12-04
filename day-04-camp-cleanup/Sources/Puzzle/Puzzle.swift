import AdventKit
import Foundation

class Puzzle {
    let assignments: [(Set<Int>, Set<Int>)]

    init(input: String) {
        assignments = input.trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map {
                let x = $0.components(separatedBy: ",")
                let a = x[0].components(separatedBy: "-").compactMap(Int.init)
                let b = x[1].components(separatedBy: "-").compactMap(Int.init)
                return (Set(a[0]...a[1]), Set(b[0]...b[1]))
            }
    }

    func part1() -> Int {
        assignments
            .filter { $0.0.isSubset(of: $0.1) || $0.1.isSubset(of: $0.0) }
            .count
    }

    func part2() -> Int {
        assignments
            .filter { !$0.0.isDisjoint(with: $0.1) }
            .count
    }
}
