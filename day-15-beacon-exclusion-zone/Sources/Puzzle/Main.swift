@main
public enum Main {
    public static func main() {
        let puzzle = Puzzle(input: try! String(contentsOfFile: "input.txt"))
        print("Part 1: \(puzzle.part1(row: 2_000_000))")
        print("Part 2: \(puzzle.part2(boundary: 4_000_000))")
    }
}
