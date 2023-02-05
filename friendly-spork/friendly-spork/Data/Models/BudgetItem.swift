//
//  BudgetItem.swift
//  friendly-spork
//
//  Created by James on 5/2/2023.
//

import Foundation

struct BudgetItem: Codable {
    let name: String
    let maximumValue: Double
    let currentValue: Double
}
