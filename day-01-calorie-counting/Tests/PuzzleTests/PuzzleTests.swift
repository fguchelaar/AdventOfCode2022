@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    let input = """
    1000
    2000
    3000

    4000

    5000
    6000

    7000
    8000
    9000

    10000
    """

    func testPart1() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part1(), 24000)
    }

    func testPart2() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part2(), 45000)
    }
}
