import AdventKit
import Foundation

class Puzzle {
    var stacks: [[Character]]
    let steps: [[Int]]
    
    init(input: String) {
        let parts = input.components(separatedBy: "\n\n")
        
        // reverse order to more easily fill the stacks
        let stackInfo = parts[0]
            .components(separatedBy: .newlines)
        
        // The last line contains the number of stacks
        let numberOfStacks = stackInfo.last!.split(separator: " ", omittingEmptySubsequences: true).count
        stacks = Array(repeating: [Character](), count: numberOfStacks)
        
        // next fill up the stacks
        for i in stride(from: stackInfo.count - 2, through: 0, by: -1) {
            for j in 0 ..< numberOfStacks {
                let position = j * 4 + 1
                if let crate = stackInfo[i].character(at: position),
                   crate != " "
                {
                    stacks[j].append(crate)
                }
            }
        }
        
        // Parse the integers from the second part, to get the steps: [[number:Int, from:Int, to:Int]]
        // compactMap helps by discarding all non-integer tokens
        steps = parts[1]
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map { $0.components(separatedBy: " ").compactMap(Int.init) }
    }
    
    func part1() -> String {
        var stacks = stacks
        steps.forEach { step in
            stacks[step[2] - 1].append(contentsOf: stacks[step[1] - 1].suffix(step[0]).reversed())
            stacks[step[1] - 1].removeLast(step[0])
        }
        return String(stacks.compactMap { $0.last })
    }
    
    func part2() -> String {
        var stacks = stacks
        steps.forEach { step in
            stacks[step[2] - 1].append(contentsOf: stacks[step[1] - 1].suffix(step[0]))
            stacks[step[1] - 1].removeLast(step[0])
        }
        return String(stacks.compactMap { $0.last })
    }
}
