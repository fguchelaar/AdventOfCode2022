//
//  Node.swift
//
//
//  Created by Frank Guchelaar on 31/12/2022.
//

import Foundation

public class Node<Element> {
    public var previous: Node<Element>?
    public var next: Node<Element>?
    public var element: Element

    public init(element: Element, previous: Node<Element>? = nil, next: Node<Element>? = nil) {
        self.previous = previous
        self.next = next
        self.element = element
    }
}
