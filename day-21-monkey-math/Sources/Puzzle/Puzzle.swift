import AdventKit
import Foundation

class Puzzle {
    var jobs: [String: String]

    init(input: String) {
        self.jobs = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .reduce(into: [String: String]()) { map, line in
                let parts = line.components(separatedBy: ": ")
                map[parts[0]] = parts[1]
            }
    }

    func part1() -> Int {
        Int(solve(for: "root"))
    }

    func solve(for monkey: String) -> Double {
        if let value = Double(jobs[monkey]!) {
            return value
        } else {
            let parts = jobs[monkey]!.components(separatedBy: " ")
            let o1 = solve(for: parts[0])
            let o2 = solve(for: parts[2])
            switch parts[1] {
            case "+": return o1 + o2
            case "-": return o1 - o2
            case "*": return o1 * o2
            case "/": return o1 / o2
            default: fatalError("unexpected operator \(parts[1])")
            }
        }
    }

    func part2() -> Int {
        let parts = jobs["root"]!.components(separatedBy: " ")
        let a1 = solve(for: parts[0])
        let b1 = solve(for: parts[2])

        let humn = Int(jobs["humn"]!)!
        jobs["humn"] = "\(humn + 1)"

        // which operand do we influence
        let a2 = solve(for: parts[0])
        let b2 = solve(for: parts[2])

        let increaseMakesAGoUp = a1 != a2 ? a2 > a1 : b2 > b1

        var upper = 10_000_000_000_000
        var lower = 0
        var guess = upper / 2

        while upper > lower {
            jobs["humn"] = "\(guess)"
            let a = solve(for: parts[0])
            let b = solve(for: parts[2])

            if a == b {
                return guess
            } else if a > b {
                if increaseMakesAGoUp {
                    upper = guess
                    guess -= (guess - lower) / 2
                } else {
                    lower = guess
                    guess += (upper - guess) / 2
                }
            } else {
                if increaseMakesAGoUp {
                    lower = guess
                    guess += (upper - guess) / 2
                } else {
                    upper = guess
                    guess -= (guess - lower) / 2
                }
            }
        }

        return upper
    }
}
