import AdventKit
import Foundation

class Puzzle {
    let values: [Int]

    init(input: String) {
        values = ([1] + input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .flatMap { line in
                let parts = line.components(separatedBy: " ")
                switch parts[0] {
                case "addx":
                    return [0, Int(parts[1])!]
                default:
                    return [0]
                }
            })
            .reduce(into: [Int]()) {
                $0.append($1 + ($0.last ?? 0))
            }
    }

    func part1() -> Int {
        // ticks of interest
        [20, 60, 100, 140, 180, 220].reduce(0) { sum, index in
            sum + values[index - 1] * index
        }
    }

    func part2() -> [String] {
        var output = [String]()
        var line = ""

        values.enumerated().forEach { step in

            let cycle = ((step.offset) % 40)
            let x = step.element
            line.append([x - 1, x, x + 1].contains(cycle) ? "#" : ".")

            if line.count == 40 {
                output.append(line)
                line = ""
            }
        }
        return output
    }
}
