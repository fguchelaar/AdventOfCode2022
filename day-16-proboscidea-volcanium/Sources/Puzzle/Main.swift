@main
public enum Main {
    public static func main() {
        let puzzle = Puzzle(input: try! String(contentsOfFile: "/Users/frank/Workspace/github/fguchelaar/AdventOfCode2022/day-16-proboscidea-volcanium/input.txt"))
        print("Part 1: \(puzzle.part1())")
        print("Part 2: \(puzzle.part2())")
    }
}
