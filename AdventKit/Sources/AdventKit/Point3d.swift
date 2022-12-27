//
//  Point3d.swift
//
//
//  Created by Frank Guchelaar on 30/11/2022.
//

import Foundation

public struct Point3d: Equatable, Hashable {
    public let x: Int
    public let y: Int
    public let z: Int

    public static var zero: Point3d {
        Point3d(x: 0, y: 0, z: 0)
    }

    public init(x: Int, y: Int, z: Int) {
        self.x = x
        self.y = y
        self.z = z
    }

    public var up: Point3d {
        Point3d(x: x, y: y + 1, z: z)
    }

    public var right: Point3d {
        Point3d(x: x + 1, y: y, z: z)
    }

    public var down: Point3d {
        Point3d(x: x, y: y - 1, z: z)
    }

    public var left: Point3d {
        Point3d(x: x - 1, y: y, z: z)
    }

    public var front: Point3d {
        Point3d(x: x, y: y, z: z - 1)
    }

    public var back: Point3d {
        Point3d(x: x, y: y, z: z + 1)
    }

    public var n6: [Point3d] {
        [up, right, down, left, front, back]
    }

    /// Calculates the distance between two point, using _manhattan distance_.
    /// - Returns: distance between two point
    public func manhattan(to other: Point3d) -> Int {
        abs(other.x - x) + abs(other.y - y)
    }

    /// Add the x- and y-values to create a new Point3d
    /// - Returns: a Point3d with the x- and y-values added to each other
    public static func + (lhs: Point3d, rhs: Point3d) -> Point3d {
        Point3d(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }
}
