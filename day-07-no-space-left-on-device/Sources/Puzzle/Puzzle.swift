import AdventKit
import Foundation

class Puzzle {
    var folderSizes = [String: Int]()

    init(input: String) {
        var pwd = [String]()
        // process each line and sum up all the file sizes
        input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines).forEach { line in
                if line.starts(with: "$ cd /") {
                    pwd.removeAll()
                } else if line.starts(with: "$ cd ..") {
                    pwd.removeLast()
                } else if line.starts(with: "$ cd") {
                    pwd.append(line.components(separatedBy: " ")[2])
                } else if line.starts(with: "dir") || line.starts(with: "$ ls") {
                    // noop
                } else {
                    let size = Int(line.components(separatedBy: " ")[0])!
                    absolutePaths(for: pwd).forEach {
                        folderSizes[$0] = folderSizes[$0, default: 0] + size
                    }
                }
            }
    }

    /// Creates an array of strings with absolute paths for each pathcomponent in the 'stack'
    func absolutePaths(for pwd: [String]) -> [String] {
        var paths = ["/"]
        var pwd = pwd
        while !pwd.isEmpty {
            paths.append("/\(pwd.joined(separator: "/"))")
            pwd.removeLast()
        }
        return paths
    }

    func part1() -> Int {
        folderSizes.values
            .filter { $0 < 100_000 }
            .reduce(0, +)
    }

    func part2() -> Int {
        let available = 70_000_000
        let needed = 30_000_000
        let used = folderSizes["/"]!
        let threshold = needed - (available - used)
        return folderSizes
            .values
            .sorted()
            .first { $0 >= threshold }!
    }
}
