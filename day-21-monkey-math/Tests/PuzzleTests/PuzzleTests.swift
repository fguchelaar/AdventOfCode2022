@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    let input = """
    root: pppw + sjmn
    dbpl: 5
    cczh: sllz + lgvd
    zczc: 2
    ptdq: humn - dvpt
    dvpt: 3
    lfqf: 4
    humn: 5
    ljgn: 2
    sjmn: drzm * dbpl
    sllz: 4
    pppw: cczh / lfqf
    lgvd: ljgn * ptdq
    drzm: hmdt - zczc
    hmdt: 32
    """

    func testPart1() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part1(), 152)
    }

    func testPart2() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part2(), 301)
    }
}
