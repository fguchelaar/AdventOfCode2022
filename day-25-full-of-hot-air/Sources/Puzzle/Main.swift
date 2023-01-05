@main
public enum Main {
    public static func main() {
        let puzzle = Puzzle(input: try! String(contentsOfFile: "input.txt"))
        print("Part 1: \(puzzle.part1())")
    }
}
