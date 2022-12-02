import AdventKit
import Foundation

class Puzzle {
    let input: String
    
    init(input: String) {
        self.input = input
    }
    
    func part1() -> Int {
        input
            .components(separatedBy: .newlines)
            .reduce(0) { $0 + score1(for: $1) }
    }
    
    func score1(for line: String) -> Int {
        switch line.trimmingCharacters(in: .whitespacesAndNewlines) {
        case "A X": return 3 + 1
        case "A Y": return 6 + 2
        case "A Z": return 0 + 3
        case "B X": return 0 + 1
        case "B Y": return 3 + 2
        case "B Z": return 6 + 3
        case "C X": return 6 + 1
        case "C Y": return 0 + 2
        case "C Z": return 3 + 3
        default: return 0
        }
    }
    
    func part2() -> Int {
        input
            .components(separatedBy: .newlines)
            .reduce(0) { $0 + score2(for: $1) }
    }
    
    func score2(for line: String) -> Int {
        switch line.trimmingCharacters(in: .whitespacesAndNewlines) {
        case "A X": return 0 + 3
        case "A Y": return 3 + 1
        case "A Z": return 6 + 2
        case "B X": return 0 + 1
        case "B Y": return 3 + 2
        case "B Z": return 6 + 3
        case "C X": return 0 + 2
        case "C Y": return 3 + 3
        case "C Z": return 6 + 1
        default: return 0
        }
    }
}
