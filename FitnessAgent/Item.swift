//
//  Item.swift
//  FitnessAgent
//
//  Created by Vincent Joy on 21/05/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
