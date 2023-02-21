//
//  BudgetInterval.swift
//  friendly-spork
//
//  Created by James on 5/2/2023.
//

import Foundation

class BudgetInterval: Codable {
    let id: String
    let startDateTime: Date
    let endDateTime: Date
    var items: [BudgetItem]
    
    // MARK: - Initialization
    
    init(startDateTime: Date, endDateTime: Date, items: [BudgetItem]) {
        self.id = UUID().uuidString
        self.startDateTime = startDateTime
        self.endDateTime = endDateTime
        self.items = items
    }
    
    // MARK: - Variable
    
    var maxAmount: Double {
        items
            .map { $0.maximumValue }
            .reduce(0, +)
    }
    
    var totalAmount: Double {
        items
            .map { $0.currentValue }
            .reduce(0, +)
    }
    
    var intervalTitle: String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        return formatter.string(from: startDateTime) + " - " + formatter.string(from: endDateTime)
    }
    
    var amountString: String {
        if totalAmount > maxAmount {
            return "+$\(totalAmount - maxAmount)"
        }
        return "-$\(maxAmount - totalAmount)"
    }
}

extension BudgetInterval: Hashable {
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}

extension BudgetInterval: Equatable {
    static func == (lhs: BudgetInterval, rhs: BudgetInterval) -> Bool {
        lhs.startDateTime == rhs.startDateTime &&
        lhs.endDateTime == rhs.endDateTime &&
        lhs.items == rhs.items
    }
}
