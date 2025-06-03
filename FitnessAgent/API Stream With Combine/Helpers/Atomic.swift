//
//  Atomic.swift
//  FitnessAgent
//
//  Created by Vincent Joy on 03/06/25.
//

import Foundation

@propertyWrapper
final class Atomic<T> {
    private var value: T
    private let queue = DispatchQueue(label: "atomic.queue", attributes: .concurrent)
    
    init(wrappedValue: T) {
        self.value = wrappedValue
    }
    
    var wrappedValue: T {
        get {
            queue.sync { value }
        }
        set {
            queue.async(flags: .barrier) {
                self.value = newValue
            }
        }
    }
}
