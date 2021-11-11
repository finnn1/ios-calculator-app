//
//  LinkedList.swift
//  Calculator
//
//  Created by 이호영 on 2021/11/09.
//

import Foundation

class Node {
    var data: CalculateItem?
    var next: Node?
    
    init(data: CalculateItem?, next: Node? = nil) {
        self.data = data
        self.next = next
    }
}

struct LinkedList {
    private var head: Node?
    private var tail: Node?
    
    mutating func append(data: CalculateItem?) {
        let newNode = Node(data: data)
        
        if tail != nil {
            tail?.next = newNode
        }
        tail = newNode
        
        if head == nil {
            self.head = tail
        }
    }
    
    mutating func removeFrist() -> CalculateItem? {
        if head == nil {
            return nil
        }
        
        let removedData = head?.data
        self.head = head?.next
      
        return removedData
    }
    
    mutating func clear() {
        head = nil
        tail = nil
    }
    
    func front() -> Node? {
        return self.head
    }
}