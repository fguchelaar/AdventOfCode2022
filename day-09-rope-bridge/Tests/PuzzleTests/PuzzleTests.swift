@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    func testPart1() throws {
        let puzzle = Puzzle(input: """
        R 4
        U 4
        L 3
        D 1
        R 4
        D 1
        L 5
        R 2
        """)
        XCTAssertEqual(puzzle.part1(), 13)
    }

    func testPart2() throws {
        let puzzle = Puzzle(input: """
        R 5
        U 8
        L 8
        D 3
        R 17
        D 10
        L 25
        U 20
        """)
        XCTAssertEqual(puzzle.part2(), 36)
    }
}
