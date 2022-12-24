import AdventKit
import Collections
import Foundation

struct Valve: Hashable, Equatable {
    let name: String
    let flow: Int
    let neighbors: [String]
}

class Puzzle {
    let valves: [Valve]

    init(input: String) {
        let regex = try! NSRegularExpression(pattern: #"Valve (\w+) has flow rate=(\d+); tunnel(s?) lead(s?) to valve(s?) (.*)"#, options: .anchorsMatchLines)

        valves = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map {
                let nsstring = $0 as NSString
                let matches = regex.matches(in: $0, range: NSRange(location: 0, length: $0.utf16.count))
                return Valve(name: nsstring.substring(with: matches[0].range(at: 1)),
                             flow: Int(nsstring.substring(with: matches[0].range(at: 2)))!,
                             neighbors: nsstring.substring(with: matches[0].range(at: 6)).components(separatedBy: ", "))
            }
    }

    /// Do a BFS for the list of valves and return a map with the distance form `start` to all other nodes
    func distanceMap(from start: Valve, in valves: [Valve]) -> [Valve: Int] {
        var queue = Deque<Valve>([start])
        var explored = Set<Valve>([start])
        var distance = [start: 0]

        while !queue.isEmpty {
            let node = queue.removeFirst()

            for neighbor in valves.filter({ node.neighbors.contains($0.name) }) {
                if !explored.contains(neighbor) {
                    explored.insert(neighbor)
                    queue.append(neighbor)
                    distance[neighbor] = distance[node]! + 1
                }
            }
        }
        return distance
    }

    func valve(for name: String) -> Valve {
        valves.first { $0.name == name }!
    }

    func part1() -> Int {
        let distanceMaps: [String: [Valve: Int]]
        // Create distance maps for all valves that have flow
        distanceMaps = (valves
            .filter { $0.flow > 0 || $0.name == "AA" })
            .reduce(into: [String: [Valve: Int]]()) { maps, valve in
                maps[valve.name] = distanceMap(from: valve, in: valves)
            }

        solvePart1(start: valve(for: "AA"), distanceMaps: distanceMaps, visited: [], pressure: 0, ttl: 30)
        return maxPart1
    }

    var maxPart1 = Int.min

    func solvePart1(start: Valve, distanceMaps: [String: [Valve: Int]], visited: [Valve], pressure: Int, ttl: Int) {
        if ttl == 0 {
            maxPart1 = max(maxPart1, pressure)
            return
        }

        let distanceMap = distanceMaps[start.name]!

        let toVisit = valves.filter {
            $0.flow > 0
                && !visited.contains($0)
                && distanceMap[$0]! < ttl
        }

        let potentialMaxPressure = toVisit.reduce(0) {
            $0 + (ttl - distanceMap[$1]! - 1) * $1.flow
        }
        if pressure + potentialMaxPressure < maxPart1 {
            return
        }

        if toVisit.isEmpty {
            maxPart1 = max(maxPart1, pressure)
            return
        }

        toVisit.forEach { next in

            let nextDistance = distanceMap[next]!
            let nextPressure = next.flow * (ttl - nextDistance - 1)

            solvePart1(start: next,
                       distanceMaps: distanceMaps,
                       visited: visited + [next],
                       pressure: pressure + nextPressure,
                       ttl: ttl - nextDistance - 1)
        }
    }

    func part2() -> Int {
        let distanceMaps: [String: [Valve: Int]]
        // Create distance maps for all valves that have flow
        distanceMaps = (valves
            .filter { $0.flow > 0 || $0.name == "AA" })
            .reduce(into: [String: [Valve: Int]]()) { maps, valve in
                maps[valve.name] = distanceMap(from: valve, in: valves)
            }

        solvePart2(start1: valve(for: "AA"), start2: valve(for: "AA"), distanceMaps: distanceMaps, visited: [], pressure: 0, ttl1: 26, ttl2: 26)
        return maxPart2
    }

    var maxPart2 = Int.min

    func solvePart2(start1: Valve, start2: Valve, distanceMaps: [String: [Valve: Int]], visited: [Valve], pressure: Int, ttl1: Int, ttl2: Int) {
        // ran out of time
        if ttl1 <= 0 && ttl2 <= 0 {
            maxPart2 = max(maxPart2, pressure)
            return
        }

        let distanceMap1 = distanceMaps[start1.name]!
        let distanceMap2 = distanceMaps[start2.name]!

        let toVisit1 = valves.filter {
            $0.flow > 0
                && !visited.contains($0)
                && distanceMap1[$0]! < ttl1
        }

        let toVisit2 = valves.filter {
            $0.flow > 0
                && !visited.contains($0)
                && distanceMap2[$0]! < ttl2
        }

        let potentialMaxPressure1 = toVisit1.reduce(0) {
            $0 + (ttl1 - distanceMap1[$1]! - 1) * $1.flow
        }
        let potentialMaxPressure2 = toVisit2.reduce(0) {
            $0 + (ttl2 - distanceMap2[$1]! - 1) * $1.flow
        }

        if pressure + potentialMaxPressure1 + potentialMaxPressure2 < maxPart2 {
            return
        }

        // ran out of valves to visit
        if toVisit1.isEmpty && toVisit2.isEmpty {
            maxPart2 = max(maxPart2, pressure)
            return
        }

        if toVisit1.isEmpty {
            toVisit2.forEach { next2 in
                let nextDistance2 = distanceMap2[next2]!
                let nextPressure2 = next2.flow * (ttl2 - nextDistance2 - 1)
                solvePart2(start1: start1,
                           start2: next2,
                           distanceMaps: distanceMaps,
                           visited: visited + [next2],
                           pressure: pressure + nextPressure2,
                           ttl1: ttl1,
                           ttl2: ttl2 - nextDistance2 - 1)
            }
        } else if toVisit2.isEmpty {
            toVisit1.forEach { next1 in
                let nextDistance1 = distanceMap1[next1]!
                let nextPressure1 = next1.flow * (ttl1 - nextDistance1 - 1)
                solvePart2(start1: next1,
                           start2: start2,
                           distanceMaps: distanceMaps,
                           visited: visited + [next1],
                           pressure: pressure + nextPressure1,
                           ttl1: ttl1 - nextDistance1 - 1,
                           ttl2: ttl2)
            }
        } else {
            toVisit1.forEach { next1 in
                let nextDistance1 = distanceMap1[next1]!
                let nextPressure1 = next1.flow * (ttl1 - nextDistance1 - 1)

                toVisit2.filter { $0 != next1 }.forEach { next2 in
                    let nextDistance2 = distanceMap2[next2]!
                    let nextPressure2 = next2.flow * (ttl2 - nextDistance2 - 1)

                    solvePart2(start1: next1,
                               start2: next2,
                               distanceMaps: distanceMaps,
                               visited: visited + [next1, next2],
                               pressure: pressure + nextPressure1 + nextPressure2,
                               ttl1: ttl1 - nextDistance1 - 1,
                               ttl2: ttl2 - nextDistance2 - 1)
                }
            }
        }
    }
}
