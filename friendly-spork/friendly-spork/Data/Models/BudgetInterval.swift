//
//  BudgetInterval.swift
//  friendly-spork
//
//  Created by James on 5/2/2023.
//

import Foundation

struct BudgetInterval: Codable {
    let startDateTime: Date
    let endDateTime: Date
    var items: [BudgetItem]
}
