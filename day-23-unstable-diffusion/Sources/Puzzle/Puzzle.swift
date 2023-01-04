import AdventKit
import Algorithms
import Foundation

class Elf {
    var position: Point
    var proposal: Point?

    init(position: Point) {
        self.position = position
    }
}

class Puzzle {
    let elves: [Elf]

    init(input: String) {
        self.elves = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .enumerated()
            .flatMap { row, line in
                line.enumerated().compactMap { col, char in
                    if char == "#" {
                        return Elf(position: Point(x: col, y: row, invertY: true))
                    } else {
                        return nil
                    }
                }
            }
    }

    func part1() -> Int {
        for round in 0 ..< 10 {
            let positions = Set(elves.map { $0.position })
            var proposalCount = [Point: Int]()
            // first halve
            for elf in elves {
                let neighbors = elf.position.n8

                // If no other Elves are in one of those eight positions, the Elf does not do anything during this round.
                if positions.isDisjoint(with: neighbors) {
                    continue
                }
                if round % 4 == 0 {
                    if positions.isDisjoint(with: [elf.position.up, elf.position.up.left, elf.position.up.right]) {
                        elf.proposal = elf.position.up
                    } else if positions.isDisjoint(with: [elf.position.down, elf.position.down.left, elf.position.down.right]) {
                        elf.proposal = elf.position.down
                    } else if positions.isDisjoint(with: [elf.position.left, elf.position.left.up, elf.position.left.down]) {
                        elf.proposal = elf.position.left
                    } else if positions.isDisjoint(with: [elf.position.right, elf.position.right.up, elf.position.right.down]) {
                        elf.proposal = elf.position.right
                    }
                } else if round % 4 == 1 {
                    if positions.isDisjoint(with: [elf.position.down, elf.position.down.left, elf.position.down.right]) {
                        elf.proposal = elf.position.down
                    } else if positions.isDisjoint(with: [elf.position.left, elf.position.left.up, elf.position.left.down]) {
                        elf.proposal = elf.position.left
                    } else if positions.isDisjoint(with: [elf.position.right, elf.position.right.up, elf.position.right.down]) {
                        elf.proposal = elf.position.right
                    } else if positions.isDisjoint(with: [elf.position.up, elf.position.up.left, elf.position.up.right]) {
                        elf.proposal = elf.position.up
                    }
                } else if round % 4 == 2 {
                    if positions.isDisjoint(with: [elf.position.left, elf.position.left.up, elf.position.left.down]) {
                        elf.proposal = elf.position.left
                    } else if positions.isDisjoint(with: [elf.position.right, elf.position.right.up, elf.position.right.down]) {
                        elf.proposal = elf.position.right
                    } else if positions.isDisjoint(with: [elf.position.up, elf.position.up.left, elf.position.up.right]) {
                        elf.proposal = elf.position.up
                    } else if positions.isDisjoint(with: [elf.position.down, elf.position.down.left, elf.position.down.right]) {
                        elf.proposal = elf.position.down
                    }
                } else if round % 4 == 3 {
                    if positions.isDisjoint(with: [elf.position.right, elf.position.right.up, elf.position.right.down]) {
                        elf.proposal = elf.position.right
                    } else if positions.isDisjoint(with: [elf.position.up, elf.position.up.left, elf.position.up.right]) {
                        elf.proposal = elf.position.up
                    } else if positions.isDisjoint(with: [elf.position.down, elf.position.down.left, elf.position.down.right]) {
                        elf.proposal = elf.position.down
                    } else if positions.isDisjoint(with: [elf.position.left, elf.position.left.up, elf.position.left.down]) {
                        elf.proposal = elf.position.left
                    }
                }

                if let proposal = elf.proposal {
                    proposalCount[proposal, default: 0] += 1
                }
            }

            // second halve
            elves.lazy
                .filter { $0.proposal != nil }
                .forEach { elf in
                    if proposalCount[elf.proposal!] == 1 {
                        elf.position = elf.proposal!
                    }
                    elf.proposal = nil
                }
        }

        let positions = Set(elves.map { $0.position })
        let minMaxX = positions.map { $0.x }.minAndMax()!
        let minMaxY = positions.map { $0.y }.minAndMax()!

        let size = (minMaxX.max - minMaxX.min + 1)
            * (minMaxY.max - minMaxY.min + 1)
            - elves.count

        return size
    }

    func part2() -> Int {
        for round in 0 ..< Int.max {
            let positions = Set(elves.map { $0.position })
            var proposalCount = [Point: Int]()
            var wantToMove = 0
            // first halve
            for elf in elves {
                let neighbors = elf.position.n8

                // If no other Elves are in one of those eight positions, the Elf does not do anything during this round.
                if positions.isDisjoint(with: neighbors) {
                    continue
                }
                wantToMove += 1
                if round % 4 == 0 {
                    if positions.isDisjoint(with: [elf.position.up, elf.position.up.left, elf.position.up.right]) {
                        elf.proposal = elf.position.up
                    } else if positions.isDisjoint(with: [elf.position.down, elf.position.down.left, elf.position.down.right]) {
                        elf.proposal = elf.position.down
                    } else if positions.isDisjoint(with: [elf.position.left, elf.position.left.up, elf.position.left.down]) {
                        elf.proposal = elf.position.left
                    } else if positions.isDisjoint(with: [elf.position.right, elf.position.right.up, elf.position.right.down]) {
                        elf.proposal = elf.position.right
                    }
                } else if round % 4 == 1 {
                    if positions.isDisjoint(with: [elf.position.down, elf.position.down.left, elf.position.down.right]) {
                        elf.proposal = elf.position.down
                    } else if positions.isDisjoint(with: [elf.position.left, elf.position.left.up, elf.position.left.down]) {
                        elf.proposal = elf.position.left
                    } else if positions.isDisjoint(with: [elf.position.right, elf.position.right.up, elf.position.right.down]) {
                        elf.proposal = elf.position.right
                    } else if positions.isDisjoint(with: [elf.position.up, elf.position.up.left, elf.position.up.right]) {
                        elf.proposal = elf.position.up
                    }
                } else if round % 4 == 2 {
                    if positions.isDisjoint(with: [elf.position.left, elf.position.left.up, elf.position.left.down]) {
                        elf.proposal = elf.position.left
                    } else if positions.isDisjoint(with: [elf.position.right, elf.position.right.up, elf.position.right.down]) {
                        elf.proposal = elf.position.right
                    } else if positions.isDisjoint(with: [elf.position.up, elf.position.up.left, elf.position.up.right]) {
                        elf.proposal = elf.position.up
                    } else if positions.isDisjoint(with: [elf.position.down, elf.position.down.left, elf.position.down.right]) {
                        elf.proposal = elf.position.down
                    }
                } else if round % 4 == 3 {
                    if positions.isDisjoint(with: [elf.position.right, elf.position.right.up, elf.position.right.down]) {
                        elf.proposal = elf.position.right
                    } else if positions.isDisjoint(with: [elf.position.up, elf.position.up.left, elf.position.up.right]) {
                        elf.proposal = elf.position.up
                    } else if positions.isDisjoint(with: [elf.position.down, elf.position.down.left, elf.position.down.right]) {
                        elf.proposal = elf.position.down
                    } else if positions.isDisjoint(with: [elf.position.left, elf.position.left.up, elf.position.left.down]) {
                        elf.proposal = elf.position.left
                    }
                }

                if let proposal = elf.proposal {
                    proposalCount[proposal, default: 0] += 1
                }
            }

            // second halve
            if wantToMove == 0 {
//                print("done!")
//                debug(round: round + 1, elves: elves)

                return round + 1
            }

            elves.lazy
                .filter { $0.proposal != nil }
                .forEach { elf in
                    if proposalCount[elf.proposal!] == 1 {
                        elf.position = elf.proposal!
                    }
                    elf.proposal = nil
                }
//            debug(round: round + 1, elves: elves)
        }
        return -1
    }

    func debug(round: Int, elves: [Elf]) {
        let positions = Set(elves.map { $0.position })
        let minMaxX = positions.map { $0.x }.minAndMax()!
        let minMaxY = positions.map { $0.y }.minAndMax()!

        print("== [\(round)] Elf layout (#\(positions.count))==")
        for row in minMaxY.min...minMaxY.max {
            var line = ""
            for col in minMaxX.min...minMaxX.max {
                line.append(positions.contains(Point(x: col, y: row)) ? "#" : ".")
            }
            print(line)
        }
    }
}
