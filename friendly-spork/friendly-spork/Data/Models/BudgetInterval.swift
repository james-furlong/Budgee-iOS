//
//  BudgetInterval.swift
//  friendly-spork
//
//  Created by James on 5/2/2023.
//

import Foundation

struct BudgetInterval: Codable, Hashable, Equatable {
    let startDateTime: Date
    let endDateTime: Date
    var items: [BudgetItem]
    
    static func == (lhs: BudgetInterval, rhs: BudgetInterval) -> Bool {
        lhs.startDateTime == rhs.startDateTime &&
        lhs.endDateTime == rhs.endDateTime &&
        lhs.items == rhs.items
    }
}
