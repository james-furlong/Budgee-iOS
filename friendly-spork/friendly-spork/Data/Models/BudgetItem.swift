//
//  BudgetItem.swift
//  friendly-spork
//
//  Created by James on 5/2/2023.
//

import Foundation

struct BudgetItem: Codable, Hashable, Equatable {
    let name: String
    let maximumValue: Double
    let currentValue: Double
    
    static func == (lhs: BudgetItem, rhs: BudgetItem) -> Bool {
        lhs.name == rhs.name &&
        lhs.maximumValue == rhs.maximumValue &&
        lhs.currentValue == rhs.currentValue
    }
}
