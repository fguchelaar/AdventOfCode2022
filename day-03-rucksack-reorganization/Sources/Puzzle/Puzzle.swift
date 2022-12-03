import AdventKit
import Foundation

extension Character {
    var intValue: Int {
        if isLowercase {
            return Int(asciiValue!) - 96
        } else {
            return Int(asciiValue!) - 38
        }
    }
}

class Puzzle {
    let input: [String]

    init(input: String) {
        self.input = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
    }

    func part1() -> Int {
        return input
            .map { (Set($0.prefix($0.count / 2)), Set($0.suffix($0.count / 2))) }
            .flatMap { $0.0.intersection($0.1) }
            .map { $0.intValue }
            .reduce(0, +)
    }

    func part2() -> Int {
        let a = stride(from: 0, to: input.count, by: 3)
        return a.map { (Set(input[$0]), Set(input[$0 + 1]), Set(input[$0 + 2])) }
            .flatMap { $0.0.intersection($0.1).intersection($0.2) }
            .map { $0.intValue }
            .reduce(0, +)
    }
}
