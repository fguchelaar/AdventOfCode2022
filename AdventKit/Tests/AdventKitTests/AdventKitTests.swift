@testable import AdventKit
import XCTest

final class AdventKitTests: XCTestCase {
    func testGCD() {
        XCTAssertEqual(gcd(15, 10), 5)
        XCTAssertEqual(gcd(10, 15), 5)
        XCTAssertEqual(gcd(91, 14), 7)

        XCTAssertEqual(gcd(91), 91)

        XCTAssertEqual(gcd(25, 15, 10), 5)
        XCTAssertEqual(gcd([25, 15, 10]), 5)
        
        XCTAssertEqual(gcd([21, 8]), 1)
        XCTAssertEqual(gcd([8,21]), 1)
    }

    func testLCM() {
        XCTAssertEqual(lcm(231, 924), 924)

        XCTAssertEqual(lcm(231), 231)

        XCTAssertEqual(lcm(231, 924, 1386), 2772)
        XCTAssertEqual(lcm([231, 924, 2772]), 2772)
    }
}
