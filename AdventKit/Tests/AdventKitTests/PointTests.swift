//
//  PointTests.swift
//
//
//  Created by Frank Guchelaar on 30/11/2022.
//

import AdventKit
import XCTest

final class PointTests: XCTestCase {
    func testNeigbours() throws {
        let p = Point(x: 5, y: 13)
        
        XCTAssertEqual(Point(x: 5, y: 14), p.up)
        XCTAssertEqual(Point(x: 6, y: 13), p.right)
        XCTAssertEqual(Point(x: 5, y: 12), p.down)
        XCTAssertEqual(Point(x: 4, y: 13), p.left)
    }
    
    func testFourNeigbours() throws {
        let p = Point(x: 5, y: 13)
        let expected = Set([
            Point(x: 5, y: 14),
            Point(x: 6, y: 13),
            Point(x: 5, y: 12),
            Point(x: 4, y: 13)
        ].shuffled())
        XCTAssertEqual(expected, Set(p.n4))
    }
    
    func testEightNeigbours() throws {
        let p = Point(x: 5, y: 13)
        let expected = Set([
            Point(x: 5, y: 14),
            Point(x: 6, y: 14),
            Point(x: 6, y: 13),
            Point(x: 6, y: 12),
            Point(x: 5, y: 12),
            Point(x: 4, y: 12),
            Point(x: 4, y: 13),
            Point(x: 4, y: 14)
        ].shuffled())
        XCTAssertEqual(expected, Set(p.n8))
    }
    
    func testNeigboursInverted() throws {
        let p = Point(x: 5, y: 13, invertY: true)
        
        XCTAssertEqual(Point(x: 5, y: 12, invertY: true), p.up)
        XCTAssertEqual(Point(x: 6, y: 13, invertY: true), p.right)
        XCTAssertEqual(Point(x: 5, y: 14, invertY: true), p.down)
        XCTAssertEqual(Point(x: 4, y: 13, invertY: true), p.left)
    }
    
    func testEightNeigboursInverted() throws {
        let p = Point(x: 5, y: 13, invertY: true)
        let expected = Set([
            Point(x: 5, y: 14, invertY: true),
            Point(x: 6, y: 14, invertY: true),
            Point(x: 6, y: 13, invertY: true),
            Point(x: 6, y: 12, invertY: true),
            Point(x: 5, y: 12, invertY: true),
            Point(x: 4, y: 12, invertY: true),
            Point(x: 4, y: 13, invertY: true),
            Point(x: 4, y: 14, invertY: true)
        ].shuffled())
        XCTAssertEqual(expected, Set(p.n8))
    }
}
