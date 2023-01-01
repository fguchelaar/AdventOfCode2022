//
//  StringProtocol+Extensions.swift
//
//
//  Created by Frank Guchelaar on 05/12/2022.
//

import Foundation

public extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
    
    func character(at index: Int) -> Character? {
        index < count ? self[index] : nil
    }
}
