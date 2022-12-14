import AdventKit
import Algorithms
import Foundation

class Puzzle {
    let packets: [Any]
    
    init(input: String) {
        packets = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .lazy
            .filter { !$0.isEmpty }
            .map { try! JSONSerialization.jsonObject(with: $0.data(using: .utf8)!) }
    }
    
    func inOrder(_ a: Any, _ b: Any) -> Bool {
        compare(a, b) < 0
    }
    
    func compare(_ a: Any, _ b: Any) -> Int {
        if let a_int = a as? Int, let b_int = b as? Int {
            return a_int - b_int
        } else {
            let arrayA = a as? [Any] ?? [a]
            let arrayB = b as? [Any] ?? [b]
            return zip(arrayA, arrayB)
                .map { compare($0.0, $0.1) }
                .first { $0 != 0 } ?? arrayA.count - arrayB.count
        }
    }
        
    func part1() -> Int {
        packets
            .chunks(ofCount: 2)
            .enumerated()
            .filter { inOrder($0.element.first!, $0.element.last!) }
            .map { $0.offset + 1 }
            .reduce(0, +)
    }
    
    func part2() -> Int {
        ([[[2]], [[6]]] + packets)
            .sorted(by: inOrder(_:_:))
            .enumerated()
            .filter { compare($0.element, [[2]]) == 0 || compare($0.element, [[6]]) == 0 }
            .map { $0.offset + 1 }
            .reduce(1, *)
    }
}
