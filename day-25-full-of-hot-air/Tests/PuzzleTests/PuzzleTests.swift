@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    let input = """
    1=-0-2
    12111
    2=0=
    21
    2=01
    111
    20012
    112
    1=-1=
    1-12
    12
    1=
    122
    """

    func testIntToSnafu() {
        XCTAssertEqual(1.snafuValue, "1")
        XCTAssertEqual(2.snafuValue, "2")
        XCTAssertEqual(3.snafuValue, "1=")
        XCTAssertEqual(4.snafuValue, "1-")
        XCTAssertEqual(5.snafuValue, "10")
        XCTAssertEqual(6.snafuValue, "11")
        XCTAssertEqual(7.snafuValue, "12")
        XCTAssertEqual(8.snafuValue, "2=")
        XCTAssertEqual(9.snafuValue, "2-")
        XCTAssertEqual(10.snafuValue, "20")
        XCTAssertEqual(15.snafuValue, "1=0")
        XCTAssertEqual(20.snafuValue, "1-0")
        XCTAssertEqual(2022.snafuValue, "1=11-2")
        XCTAssertEqual(12345.snafuValue, "1-0---0")
        XCTAssertEqual(314159265.snafuValue, "1121-1110-1=0")
    }

    func testIntFromSnafu() {
        XCTAssertEqual(.fromSnafu("1"), 1)
        XCTAssertEqual(.fromSnafu("2"), 2)
        XCTAssertEqual(.fromSnafu("1="), 3)
        XCTAssertEqual(.fromSnafu("1-"), 4)
        XCTAssertEqual(.fromSnafu("10"), 5)
        XCTAssertEqual(.fromSnafu("11"), 6)
        XCTAssertEqual(.fromSnafu("12"), 7)
        XCTAssertEqual(.fromSnafu("2="), 8)
        XCTAssertEqual(.fromSnafu("2-"), 9)
        XCTAssertEqual(.fromSnafu("20"), 10)
        XCTAssertEqual(.fromSnafu("1=0"), 15)
        XCTAssertEqual(.fromSnafu("1-0"), 20)
        XCTAssertEqual(.fromSnafu("1=11-2"), 2022)
        XCTAssertEqual(.fromSnafu("1-0---0"), 12345)
        XCTAssertEqual(.fromSnafu("1121-1110-1=0"), 314159265)
    }

    func testPart1() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part1(), "2=-1=0")
    }
}
