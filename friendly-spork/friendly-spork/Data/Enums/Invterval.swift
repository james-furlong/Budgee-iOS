//
//  Invterval.swift
//  friendly-spork
//
//  Created by James on 5/2/2023.
//

import Foundation

enum Interval: Codable, Hashable, Equatable {
    case weekly
    case fortnightly
    case monthly
    
    var name: String {
        switch self {
            case .weekly: return "Weekly"
            case .fortnightly: return "Fortnightly"
            case .monthly: return "Monthly"
        }
    }
    
    func endDate(from startDate: Date) -> Date {
        switch self {
            case .weekly: return Calendar.current.date(byAdding: .weekOfYear, value: 1, to: startDate) ?? Date()
            case .fortnightly: return Calendar.current.date(byAdding: .weekOfYear, value: 2, to: startDate) ?? Date()
            case .monthly: return Calendar.current.date(byAdding: .month, value: 1, to: startDate) ?? Date()
        }
    }
}
