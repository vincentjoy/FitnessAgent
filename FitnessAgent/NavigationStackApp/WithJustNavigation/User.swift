//
//  User.swift
//  FitnessAgent
//
//  Created by Vincent Joy on 24/05/25.
//

import Foundation

struct User: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var age: Int
}
