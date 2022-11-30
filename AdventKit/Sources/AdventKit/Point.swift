//
//  Point.swift
//
//
//  Created by Frank Guchelaar on 23/11/2022.
//

import Foundation

public struct Point: Equatable, Hashable {
    public let x: Int
    public let y: Int
    public let invertY: Bool
    
    public init(x: Int, y: Int, invertY: Bool = false) {
        self.x = x
        self.y = y
        self.invertY = invertY
    }

    public static var zero: Point {
        Point(x: 0, y: 0)
    }
    
    public static var min: Point {
        Point(x: Int.min, y: Int.min)
    }
    
    public static var max: Point {
        Point(x: Int.max, y: Int.max)
    }
    
    public var up: Point {
        Point(x: x, y: y + (invertY ? -1 : 1), invertY: invertY)
    }
    
    public var right: Point {
        Point(x: x + 1, y: y, invertY: invertY)
    }
    
    public var down: Point {
        Point(x: x, y: y - (invertY ? -1 : 1), invertY: invertY)
    }
    
    public var left: Point {
        Point(x: x - 1, y: y, invertY: invertY)
    }
    
    public var n4: [Point] {
        [up, right, down, left]
    }

    public var n8: [Point] {
        [up,
         up.right,
         right,
         right.down,
         down,
         down.left,
         left,
         left.up]
    }

    /// Calculates the distance between two point, using _manhattan distance_.
    /// - Returns: distance between two point
    public func manhattan(to other: Point) -> Int {
        abs(other.x - x) + abs(other.y - y)
    }

    /// Add the x- and y-values to create a new Point
    /// - Returns: a Point with the x- and y-values added to each other
    public static func + (lhs: Point, rhs: Point) -> Point {
        Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}
