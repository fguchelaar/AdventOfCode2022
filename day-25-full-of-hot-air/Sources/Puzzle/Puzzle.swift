import AdventKit
import Foundation

extension Int {
    var snafuValue: String {
        var snafuString = ""
        var quotient = self
        while quotient > 0 {
            let remainder = ((quotient + 2) % 5) - 2
            quotient = Int((quotient + 2) / 5)
            switch remainder {
            case -2: snafuString = "=" + snafuString
            case -1: snafuString = "-" + snafuString
            case 0: snafuString = "0" + snafuString
            case 1: snafuString = "1" + snafuString
            case 2: snafuString = "2" + snafuString
            default: fatalError()
            }
        }
        return snafuString
    }
    
    static func fromSnafu(_ string: String) -> Int {
        string.reversed().enumerated().map {
            let base: Int = .init(pow(5.0, Double($0.offset)))
            switch $0.element {
            case "=": return base * -2
            case "-": return base * -1
            case "0": return base * 0
            case "1": return base * 1
            case "2": return base * 2
            default: fatalError()
            }
        }.reduce(0,+)
    }
}

class Puzzle {
    let input: [String]
    
    init(input: String) {
        self.input = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
    }
    
    func part1() -> String {
        input
            .map(Int.fromSnafu(_:))
            .reduce(0, +)
            .snafuValue
    }
}
