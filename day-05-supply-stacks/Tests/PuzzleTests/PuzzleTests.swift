@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    let puzzle = Puzzle(input: """
        [D]
    [N] [C]
    [Z] [M] [P]
     1   2   3

    move 1 from 2 to 1
    move 3 from 1 to 3
    move 2 from 2 to 1
    move 1 from 1 to 2
    """)

    func testPart1() throws {
        XCTAssertEqual(puzzle.part1(), "CMZ")
    }

    func testPart2() throws {
        XCTAssertEqual(puzzle.part2(), "MCD")
    }
}
