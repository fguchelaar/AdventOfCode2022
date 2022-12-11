import Collections
import Foundation

class Monkey {
    var items: Deque<Int>
    var `operator`: String
    var operand: Int?
    var testOperand: Int
    var monkeyTrue: Int
    var monkeyFalse: Int
    
    var monkeyBusiness = 0
    
    init(string: String) {
        let lines = string.components(separatedBy: .newlines)
        items = Deque(lines[1]
            .components(separatedBy: CharacterSet(charactersIn: ", "))
            .compactMap(Int.init))
        let line2 = lines[2].components(separatedBy: " ")
        `operator` = line2[line2.count - 2]
        let temp = Int(line2.last!)
        operand = temp == nil ? nil : Int(temp!)
        let line3 = lines[3].components(separatedBy: " ")
        testOperand = Int(line3.last!)!
        monkeyTrue = Int(lines[4].components(separatedBy: " ").last!)!
        monkeyFalse = Int(lines[5].components(separatedBy: " ").last!)!
    }
    
    func fetchItem() -> Int {
        monkeyBusiness += 1
        let item = items.removeFirst()
        switch `operator` {
        case "+":
            return item + (operand ?? item)
        default:
            return item * (operand ?? item)
        }
    }
}
