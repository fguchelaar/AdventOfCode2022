@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    let input = ">>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>"

    func testPart1() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part1(), 3068)
    }

    func testPart2() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part2(), 1_514_285_714_288)
    }
}
