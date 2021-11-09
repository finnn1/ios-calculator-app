//
//  CalculatorItemQueue.swift
//  Calculator
//
//  Created by JeongTaek Han on 2021/11/09.
//

import Foundation

protocol CalculateItem { }

struct CalculatorItemQueue<Element> {
    var item: LinkedList<Element>
    
    var front: Element? {
        self.item[0]
    }
    
    init() {
        self.item = LinkedList()
    }
    
    func enqueue(_ item: Element) {
        self.item.append(item)
    }
    
    @discardableResult
    func dequeue() -> Element? {
        return self.item.remove(at: 0)
    }
}
