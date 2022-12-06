@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    func testPart1() throws {
        XCTAssertEqual(Puzzle(input: "mjqjpqmgbljsphdztnvjfqwrcgsmlb").part1(), 7)
        XCTAssertEqual(Puzzle(input: "bvwbjplbgvbhsrlpgdmjqwftvncz").part1(), 5)
        XCTAssertEqual(Puzzle(input: "nppdvjthqldpwncqszvftbrmjlhg").part1(), 6)
        XCTAssertEqual(Puzzle(input: "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg").part1(), 10)
        XCTAssertEqual(Puzzle(input: "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw").part1(), 11)
    }

    func testPart2() throws {
        XCTAssertEqual(Puzzle(input: "mjqjpqmgbljsphdztnvjfqwrcgsmlb").part2(), 19)
        XCTAssertEqual(Puzzle(input: "bvwbjplbgvbhsrlpgdmjqwftvncz").part2(), 23)
        XCTAssertEqual(Puzzle(input: "nppdvjthqldpwncqszvftbrmjlhg").part2(), 23)
        XCTAssertEqual(Puzzle(input: "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg").part2(), 29)
        XCTAssertEqual(Puzzle(input: "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw").part2(), 26)
    }
}
