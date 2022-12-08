//
//  File.swift
//  
//
//  Created by Frank Guchelaar on 08/12/2022.
//

import Foundation

public extension Int {
    init? (character: Character) {
        self.init(String(character))
    }
}
