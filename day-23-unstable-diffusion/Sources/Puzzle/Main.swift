@main
public enum Main {
    public static func main() {
        let puzzle1 = Puzzle(input: try! String(contentsOfFile: "input.txt"))
        print("Part 1: \(puzzle1.part1())")

        let puzzle2 = Puzzle(input: try! String(contentsOfFile: "input.txt"))
        print("Part 2: \(puzzle2.part2())")
    }
}
