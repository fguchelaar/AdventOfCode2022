import AdventKit
import Foundation

class Puzzle {
    let input: String
    
    init(input: String) {
        self.input = input
    }
    
    func initialize() -> [Monkey] {
        input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n\n")
            .map(Monkey.init)
    }
    
    func part1() -> Int {
        let monkeys = initialize()

        for _ in 0 ..< 20 {
            for monkey in monkeys {
                while !monkey.items.isEmpty {
                    let item = monkey.fetchItem() / 3
                    let target = item % monkey.testOperand == 0
                        ? monkeys[monkey.monkeyTrue]
                        : monkeys[monkey.monkeyFalse]

                    target.items.append(item)
                }
            }
        }
        
        return monkeys
            .map { $0.monkeyBusiness }
            .sorted().reversed()[0 ..< 2]
            .reduce(1, *)
    }
    
    func part2() -> Int {
        let monkeys = initialize()

        // to keep the worry-level at a manageable rate, we use the lcm of
        // all divisors to keep it 'small'
        let lcm = lcm(monkeys.map { $0.testOperand })
        for _ in 0 ..< 10_000 {
            for monkey in monkeys {
                while !monkey.items.isEmpty {
                    let item = monkey.fetchItem() % lcm
                    let target = item % monkey.testOperand == 0
                        ? monkeys[monkey.monkeyTrue]
                        : monkeys[monkey.monkeyFalse]
                    
                    target.items.append(item)
                }
            }
        }
        
        return monkeys
            .map { $0.monkeyBusiness }
            .sorted().reversed()[0 ..< 2]
            .reduce(1, *)
    }
}
