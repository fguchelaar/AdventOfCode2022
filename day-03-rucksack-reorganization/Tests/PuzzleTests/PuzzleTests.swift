@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    let input = """
    vJrwpWtwJgWrhcsFMMfFFhFp
    jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
    PmmdzqPrVvPwwTWBwg
    wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
    ttgJtRGJQctTZtZT
    CrZsJsPPZsGzwwsLwLmpwMDw
    """

    func testPart1() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part1(), 157)
    }

    func testPart2() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part2(), 70)
    }
}
