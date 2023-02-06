//
//  Budget.swift
//  friendly-spork
//
//  Created by James on 5/2/2023.
//

import Foundation

struct Budget: Codable, Hashable, Equatable {
    let id: String
    let name: String
    let intervalType: Interval
    var defaultItems: [BudgetItem]
    var intervals: [BudgetInterval]
    
    static func == (lhs: Budget, rhs: Budget) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.intervalType == rhs.intervalType &&
        lhs.defaultItems == rhs.defaultItems &&
        lhs.intervals == rhs.intervals
    }
}
