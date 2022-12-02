@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    let input = """
    A Y
    B X
    C Z
    """

    func testPart1() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part1(), 15)
    }

    func testPart2() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part2(), 12)
    }
}
