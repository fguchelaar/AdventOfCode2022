@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    let input = """
    30373
    25512
    65332
    33549
    35390
    """

    func testPart1() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part1(), 21)
    }

    func testPart2() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part2(), 8)
    }
}
