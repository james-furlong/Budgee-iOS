//
//  SettingsItem.swift
//  friendly-spork
//
//  Created by James on 19/2/2023.
//

import Foundation

enum SettingsItem: CaseIterable {
    case switchBudget
    case privacyPolicy
    
    var title: String {
        switch self {
            case .switchBudget: return "Switch budget"
            case .privacyPolicy: return "Privacy policy"
        }
    }
}
