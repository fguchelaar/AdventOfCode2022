@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    let input = """
    Blueprint 1: Each ore robot costs 4 ore. Each clay robot costs 2 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 2 ore and 7 obsidian.
    Blueprint 2: Each ore robot costs 2 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 8 clay. Each geode robot costs 3 ore and 12 obsidian.
    """

    func testPart1() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part1(), 33)
    }

    func testPart2() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part2(), 56 * 62)
    }
}
