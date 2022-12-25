import AdventKit
import Algorithms
import Foundation

struct Rock {
    let points: [Point]

    init(points: [Point]) {
        self.points = points
    }
    
    var topY: Int {
        points.map { $0.y }.max()!
    }

    var bottomY: Int {
        points.map { $0.y }.min()!
    }

    var leftX: Int {
        points.map { $0.x }.min()!
    }

    var rightX: Int {
        points.map { $0.x }.max()!
    }
    
    var left: Rock {
        Rock(points: points.map { $0.left })
    }

    var right: Rock {
        Rock(points: points.map { $0.right })
    }
    
    var down: Rock {
        Rock(points: points.map { $0.down })
    }
    
    init(pattern: String) {
        var points = [Point]()
        pattern
            .components(separatedBy: .newlines)
            .reversed()
            .enumerated().forEach { row in
                row.element
                    .enumerated()
                    .forEach { col in
                        if col.element == "#" {
                            points.append(Point(x: col.offset, y: row.offset))
                        }
                    }
            }
        self.points = points
    }
    
    func calibrated(with floor: Int, margin left: Int) -> Rock {
        let delta = Point(x: left, y: floor + 3)
        return Rock(points: points.map { $0 + delta })
    }
}

class Puzzle {
    let input: String
    
    let rockTemplates = [
        "####",
        
        """
        .#.
        ###
        .#.
        """,
        
        """
        ..#
        ..#
        ###
        """,
        
        """
        #
        #
        #
        #
        """,
        
        """
        ##
        ##
        """,
    ].map(Rock.init(pattern:))
    
    init(input: String) {
        self.input = input.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func part1() -> Int {
        solve(for: 2022)
    }
    
    func solve(for numberOfRocks: Int) -> Int {
        var rockDispenser = rockTemplates.cycled().makeIterator()
        var jetDispenser = input.cycled().makeIterator()
        var chamber = Set<Point>()
        
        var currentFloor = 0
        
        for _ in 1 ... numberOfRocks {
            guard var rock = rockDispenser.next()
            else {
                fatalError("the rock dispenser seems to be broken")
            }
            
            rock = rock.calibrated(with: currentFloor, margin: 2)
            
            repeat {
                guard let jet = jetDispenser.next()
                else {
                    fatalError("the jet dispenser seems to be broken")
                }
                
                switch jet {
                case "<":
                    if rock.leftX > 0, chamber.isDisjoint(with: rock.left.points) {
                        rock = rock.left
                    }
                case ">":
                    if rock.rightX < 6, chamber.isDisjoint(with: rock.right.points) {
                        rock = rock.right
                    }
                default: fatalError("unexpected jet: \(jet)")
                }
                
                if rock.bottomY > 0, chamber.isDisjoint(with: rock.down.points) {
                    rock = rock.down
                } else {
                    break
                }
                
            } while true
            rock.points.forEach { chamber.insert($0) }
            currentFloor = chamber.map { $0.y }.max()! + 1
        }
        
//        debug(chamber)
        return currentFloor
    }
    
    func debug(_ chamber: Set<Point>) {
        let maxY = chamber.map { $0.y }.max()! + 2
        
        for y in stride(from: maxY, through: 0, by: -1) {
            let line = (0 ... 6)
                .map { Point(x: $0, y: y) }
                .map { chamber.contains($0) ? "#" : "." }
            print("\(y)\t|\(line.joined())|")
        }
    
        print(" \t+-------+")
    }
    
    func part2() -> Int {
        // after 188 rocks we reach the first point of the repetition
        let s188 = solve(for: 188)
        
        // after 1913 the second occurence; it takes 1725 rocks to cycle
        let s1913 = solve(for: 1913)
        
        // number of cycles
        let cycles = (1000000000000 - 188) / 1725
        
        // height change in 1 cycle times the number of cycles
        let cycleHeight = cycles * (s1913 - s188)
        
        // amount of rocks left after the preample and cycles
        let rocksToGo = (1000000000000 - 188) % 1725
        
        // height for the preample plus what's left
        let s1600 = solve(for: 188 + rocksToGo)
        
        return cycleHeight + s1600
    }
}
