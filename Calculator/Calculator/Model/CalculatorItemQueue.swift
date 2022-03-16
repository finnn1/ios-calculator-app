//
//  CalculatorItemQueue.swift
//  Calculator
//
//  Created by 김태현 on 2022/03/14.
//

final class CalculatorItemQueue<T: CalculateItem> {
    let linkedList: LinkedList<T>
    
    init(node: Node<T>) {
        self.linkedList = LinkedList<T>.init(head: node)
    }
    
    func isEmpty() -> Bool {
        return linkedList.isEmpty()
    }
    
    func enqueue(_ node: Node<T>) {
        linkedList.append(node: node)
    }
    
    func dequeue() -> T? {
        linkedList.removeFirst()
    }
    
    func clear() {
        linkedList.clear()
    }
}

extension CalculatorItemQueue: Sequence {
    func makeIterator() -> queueIterator<T> {
        return queueIterator(current: self.linkedList.head)
    }
}

struct queueIterator<T>: IteratorProtocol {
    typealias Element = Node<T>
    
    var current: Element?
    
    mutating func next() -> Element? {
        if let node = current {
            current = node.next
            return node
        } else {
            return nil
        }
    }
}
