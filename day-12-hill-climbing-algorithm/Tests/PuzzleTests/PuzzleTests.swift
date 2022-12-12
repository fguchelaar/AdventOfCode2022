@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    let input = """
    Sabqponm
    abcryxxl
    accszExk
    acctuvwj
    abdefghi
    """

    func testPart1() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part1(), 31)
    }

    func testPart2() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part2(), 29)
    }
}
