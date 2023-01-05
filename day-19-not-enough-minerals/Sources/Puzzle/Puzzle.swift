import AdventKit
import Foundation

struct Blueprint {
    let id: Int
    let robots: [Robot]
}

struct Resources: Hashable {
    let ore: Int
    let clay: Int
    let obsidian: Int
    let geode: Int

    init(ore: Int = 0, clay: Int = 0, obsidian: Int = 0, geode: Int = 0) {
        self.ore = ore
        self.clay = clay
        self.obsidian = obsidian
        self.geode = geode
    }

    static func + (lhs: Resources, rhs: Resources) -> Resources {
        Resources(ore: lhs.ore + rhs.ore, clay: lhs.clay + rhs.clay, obsidian: lhs.obsidian + rhs.obsidian, geode: lhs.geode + rhs.geode)
    }

    static func - (lhs: Resources, rhs: Resources) -> Resources {
        Resources(ore: lhs.ore - rhs.ore, clay: lhs.clay - rhs.clay, obsidian: lhs.obsidian - rhs.obsidian, geode: lhs.geode - rhs.geode)
    }
}

struct Robot: Hashable {
    let cost: Resources
    let produce: Resources
    var sortOrder: Int {
        max(produce.ore, produce.clay, produce.obsidian, produce.geode)
    }

    func canBeBuild(with resources: Resources) -> Bool {
        let remainder = resources - cost
        return remainder.ore >= 0
            && remainder.clay >= 0
            && remainder.obsidian >= 0
            && remainder.geode >= 0
    }
}

struct State: Hashable {
    let produce: Resources
    let resources: Resources

    func progress(build robot: Robot?) -> State {
        var _resources = resources + produce
        var _produce = produce
        if let robot = robot {
            if !robot.canBeBuild(with: resources) {
                fatalError("not enough resources")
            }
            _resources = _resources - robot.cost
            _produce = _produce + robot.produce
        }
        return State(produce: _produce, resources: _resources)
    }
}

class Puzzle {
    let blueprints: [Blueprint]

    init(input: String) {
        // let's just assume every blueprint follows the same recipe-layout
        blueprints = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map { line in
                let ints = line.components(separatedBy: CharacterSet(charactersIn: " :")).compactMap(Int.init)
                return Blueprint(id: ints[0], robots: [
                    Robot(cost: Resources(ore: ints[1]), produce: Resources(ore: 1)),
                    Robot(cost: Resources(ore: ints[2]), produce: Resources(clay: 1)),
                    Robot(cost: Resources(ore: ints[3], clay: ints[4]), produce: Resources(obsidian: 1)),
                    Robot(cost: Resources(ore: ints[5], obsidian: ints[6]), produce: Resources(geode: 1))
                ])
            }
    }

    func findPossibleNextStates(blueprint: Blueprint, state: State) -> [State] {
        // always prefer the geode-bot
        let geode = blueprint.robots.last!
        if geode.canBeBuild(with: state.resources) {
            return [state.progress(build: geode)]
        }

        let eligible = blueprint.robots.filter {
            if $0.produce.ore == 1
                && state.produce.ore >= blueprint.robots.map({ $0.cost.ore }).max()!
            {
                return false
            }
            if $0.produce.clay == 1
                && state.produce.clay >= blueprint.robots.map({ $0.cost.clay }).max()!
            {
                return false
            }
            if $0.produce.obsidian == 1
                && state.produce.obsidian >= blueprint.robots.map({ $0.cost.obsidian }).max()!
            {
                return false
            }

            return $0.canBeBuild(with: state.resources)
        }

        return eligible.map { state.progress(build: $0) } + [state.progress(build: nil)]
    }

    func solve(with minutes: Int, and blueprints: [Blueprint]) -> [Int] {
        var geodes = [Int]()

        for blueprint in blueprints {
            let geode = blueprint.robots[3]

            // initial state
            var states = Set([State(produce: Resources(ore: 1), resources: Resources())])

            for minute in 1 ... minutes {
                states = Set(states.flatMap { state in
                    findPossibleNextStates(blueprint: blueprint, state: state)
                })

                let stepsLeft = minutes - minute

                // not very precise, but weeds out states near the end that will never produce a geode-bot
                let cumulativeStepsLeft = (stepsLeft * (stepsLeft + 1)) / 2
                states = states.filter { state in
                    state.produce.geode > 0 ||
                        (state.resources.obsidian + cumulativeStepsLeft) > geode.cost.obsidian
                }

                // discard all states with 0 geodes, if there are already geode-producing-states
                let hasGeode = states.contains { $0.produce.geode > 1 }
                if hasGeode {
                    states = states.filter { $0.produce.geode > 0 }
                }

                // discard all states that have no geode-bots in the last minute
                if minute == minutes - 1 {
                    states = states.filter { $0.produce.geode > 0 }
                }
            }
            geodes.append(states.max(by: { $0.resources.geode < $1.resources.geode })?.resources.geode ?? 0)
        }

        return geodes
    }

    func part1() -> Int {
        solve(with: 24, and: blueprints).enumerated().reduce(0) {
            $0 + $1.element * ($1.offset + 1)
        }
    }

    func part2() -> Int {
        solve(with: 32, and: Array(blueprints.prefix(3))).reduce(1, *)
    }
}
