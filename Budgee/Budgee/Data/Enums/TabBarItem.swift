//
//  TabBarItem.swift
//  friendly-spork
//
//  Created by James on 17/2/2023.
//


import SwiftUI

enum TabBarItem: CaseIterable {
    case home
    case spendHistory
    case add
    case budgetHistory
    case settings
    
    var icon: Image {
        switch self {
            case .home: return Image(systemName: "house")
            case .spendHistory: return Image(systemName: "dollarsign.circle")
            case .add: return Image(systemName: "plus")
            case .budgetHistory: return Image(systemName: "list.bullet.rectangle.portrait")
            case .settings: return Image(systemName: "gearshape.2")
        }
    }
}
