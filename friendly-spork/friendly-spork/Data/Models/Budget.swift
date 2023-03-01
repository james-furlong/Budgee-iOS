//
//  Budget.swift
//  friendly-spork
//
//  Created by James on 5/2/2023.
//

import Foundation

class Budget: Codable, ObservableObject {
    let id: String
    let name: String
    let intervalType: Interval
    var defaultItems: [BudgetItem]
    var intervals: [BudgetInterval]
    let oneOff: Bool
    var isActive: Bool
    
    // MARK: - Initialization
    
    init(id: String, name: String, intervalType: Interval, defaultItems: [BudgetItem], intervals: [BudgetInterval], oneOff: Bool, isActive: Bool = true) {
        self.id = id
        self.name = name
        self.intervalType = intervalType
        self.defaultItems = defaultItems
        self.intervals = intervals
        self.oneOff = oneOff
        self.isActive = isActive
    }
    
    var expenseCountTitle: String {
        return "\(defaultItems.count) expense categories"
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
    
    var activeText: String {
        return isActive ? "Active" : "Inactive"
    }
    
    var currentInterval: BudgetInterval? {
        intervals
            .sorted(by: { $0.startDateTime > $1.startDateTime })
            .first
    }
    
    // MARK: - Functions
    
    public func addSpendItem(item: ExpenseItem, itemId: String) {
        let budgetItem: BudgetItem? = currentInterval?.items.first(where: { $0.id == itemId })
        budgetItem?.expenseItems.append(item)
        do {
            try Injector.fileManager.saveOrUpdateBudget(budget: self)
        }
        catch {
            Injector.log.error("Couldn't save spend item")
        }
    }
    
    public func toggleActiveState(_ isActive: Bool) {
        self.isActive = isActive
    }
}

extension Budget: Hashable {
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}

extension Budget: Equatable {
    static func == (lhs: Budget, rhs: Budget) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.intervalType == rhs.intervalType &&
        lhs.defaultItems == rhs.defaultItems &&
        lhs.intervals == rhs.intervals
    }
}
