@main
public enum Main {
    public static func main() {
        let puzzle = Puzzle(input: try! String(contentsOfFile: "input.txt"))
        print("Part 1: \(puzzle.part1())")
        print("Part 2: \n\(puzzle.part2().joined(separator: "\n"))")
    }
}
