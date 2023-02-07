//
//  BudgetItem.swift
//  friendly-spork
//
//  Created by James on 5/2/2023.
//

import Foundation

struct BudgetItem: Codable, Hashable {
    let name: String
    let maximumValue: Double
    let currentValue: Double
    
    var isUnderBudget: Bool {
        return currentValue <= maximumValue
    }
}

extension BudgetItem: Equatable {
    static func == (lhs: BudgetItem, rhs: BudgetItem) -> Bool {
        lhs.name == rhs.name &&
        lhs.maximumValue == rhs.maximumValue &&
        lhs.currentValue == rhs.currentValue
    }
}
