//
//  Budget.swift
//  friendly-spork
//
//  Created by James on 5/2/2023.
//

import Foundation

struct Budget: Codable {
    let id: String
    let name: String
    let intervalType: Interval
    var defaultItems: [BudgetItem]
    var intervals: [BudgetInterval]
}
