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
    
    var statusTitle: String {
        if isUnderBudget {
            return "Under budget"
        }
        
        return "Over budget!"
    }
    
    var isUnderBudget: Bool {
        guard let interval = currentInterval else { return false }
        for item in interval.items {
            guard item.currentValue <= item.maximumValue else {
                return false
            }
        }
        
        return true
    }
    
    var currentInterval: BudgetInterval? {
        intervals
            .sorted(by: { $0.startDateTime > $1.startDateTime })
            .first
    }
}
