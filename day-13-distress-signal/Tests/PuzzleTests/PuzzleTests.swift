@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    let input = """
    [1,1,3,1,1]
    [1,1,5,1,1]

    [[1],[2,3,4]]
    [[1],4]

    [9]
    [[8,7,6]]

    [[4,4],4,4]
    [[4,4],4,4,4]

    [7,7,7,7]
    [7,7,7]

    []
    [3]

    [[[]]]
    [[]]

    [1,[2,[3,[4,[5,6,7]]]],8,9]
    [1,[2,[3,[4,[5,6,0]]]],8,9]
    """

    func testCompare() {
        let puzzle = Puzzle(input: "")
        XCTAssertTrue(puzzle.inOrder([1, 1, 3, 1, 1], [1, 1, 5, 1, 1]))
        XCTAssertTrue(puzzle.inOrder([], [3]))
        XCTAssertFalse(puzzle.inOrder([7, 7, 7, 7], [7, 7, 7]))
    }

    func testPart1() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part1(), 13)
    }

    func testPart2() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part2(), 140)
    }
}
