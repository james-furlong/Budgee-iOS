//
//  BudgetItem.swift
//  friendly-spork
//
//  Created by James on 5/2/2023.
//

import Foundation
import SwiftUI

class BudgetItem: Codable {
    let id: String
    let name: String
    let maximumValue: Double
    var expenseItems: [ExpenseItem]
    
    // MARK: - Initialization
    
    init(from budget: BudgetItem) {
        self.id = budget.id
        self.name = budget.name
        self.maximumValue = budget.maximumValue
        self.expenseItems = []
    }
    
    init(name: String, maxValue: Double) {
        self.id = UUID().uuidString
        self.name = name
        self.maximumValue = maxValue
        self.expenseItems = []
    }
    
    init(name: String, maxValue: Double, items: [ExpenseItem]) {
        self.id = UUID().uuidString
        self.name = name
        self.maximumValue = maxValue
        self.expenseItems = items
    }
    
    // MARK: - Computed values
    
    var currentValue: Double {
        return expenseItems
            .map { $0.amount }
            .reduce(0, +)
    }
    
    var isUnderBudget: Bool {
        return currentValue <= maximumValue
    }
    
    var remainingAmount: String {
        if isUnderBudget {
            return "$\(String(format: "%.2f", maximumValue - currentValue ))"
        }
        return "-$\(String(format: "%.2f", currentValue - maximumValue))"
    }
    
    var currentAmount: String {
        if isUnderBudget {
            return "$\(String(format: "%.2f", maximumValue - currentValue))"
        }
        return "-$\(String(format: "%.2f", currentValue - maximumValue))"
    }
    
    var progressPercent: String {
        let perc = (currentValue / maximumValue) * 100
        return String(format: "%.0f", perc) + "%"
    }
    
    var progressBarColor: Color {
        if currentValue >= maximumValue {
            return Theme.Color.red
        }
        if currentValue >= maximumValue * 0.9 {
            return Theme.Color.orange
        }
        
        return Theme.Color.teal100
    }
    
    var progressTextColor: Color {
        if currentValue >= maximumValue {
            return Theme.Color.textHardSupp
        }
        return Theme.Color.textHard
    }
    
    // MARK: - Functions
    
    func addExpense(_ item: ExpenseItem) {
        expenseItems.append(item)
    }
    
    func progressHeightPadding(geoHeight: Double) -> Double {
        let perc = currentValue / maximumValue // 25 / 100 = .25
        let progressHeight = geoHeight * perc // 200 * .25 = 50
        let padding = geoHeight - progressHeight // 200 - 50 = 150
        if padding >= 0 {
            return padding
        }
        return 0
    }
    
    func progressHeight(geoHeight: Double) -> Double {
        let perc = currentValue / maximumValue
        return geoHeight * perc
    }
}

extension BudgetItem: Equatable {
    static func == (lhs: BudgetItem, rhs: BudgetItem) -> Bool {
        lhs.name == rhs.name &&
        lhs.maximumValue == rhs.maximumValue &&
        lhs.currentValue == rhs.currentValue
    }
}

extension BudgetItem: Hashable {
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}

struct ExpenseItem: Codable, Hashable {
    let name: String
    let amount: Double
    let date: Date
    
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        return formatter.string(from: date)
    }
}
