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
}
