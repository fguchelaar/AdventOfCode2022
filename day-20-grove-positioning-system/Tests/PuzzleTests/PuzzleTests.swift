@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    let input = """
    1
    2
    -3
    3
    -2
    0
    4
    """

    func testPart1() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part1(), 3)
    }

    func testPart2() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part2(), 1623178306)
    }
}
