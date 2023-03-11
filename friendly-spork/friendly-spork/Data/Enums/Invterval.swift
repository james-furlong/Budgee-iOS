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
    
    var component: Calendar.Component {
        switch self {
            case .weekly, .fortnightly: return .weekOfYear
            case .monthly: return .month
        }
    }
    
    var componentNum: Int {
        switch self {
            case .fortnightly: return 2
            default: return 1
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
