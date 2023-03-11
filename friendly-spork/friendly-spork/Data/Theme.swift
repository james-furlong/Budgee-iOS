//
//  Theme.swift
//  friendly-spork
//
//  Created by James on 7/2/2023.
//

import SwiftUI

public struct Theme {
    public struct Color {}
    public struct Font {}
    public struct Constants {}
}

extension Theme.Color {
    // Main
    static let navy: Color = Color("Navy")
    static let red: Color = Color("Red")
    static let yellow: Color = Color("Yellow")
    static let orange: Color = Color("Orange")
    
    // Teal
    static let teal100: Color = Color("Teal100")
    static let teal70: Color = Color("Teal70")
    static let teal40: Color = Color("Teal40")
    static let teal20: Color = Color("Teal20")
    
    // Text
    static let text: Color = Color("Text")
    static let textSupp: Color = Color("TextSupp")
    static let textHard: Color = Color("TextHard")
    static let textHardSupp: Color = Color("TextHardSupp")
    
    // Background
    static let background: Color = Color("Background")
    static let backgroundSupp: Color = Color("BackgroundSupp")
    static let backgroundCell: Color = Color("BackgroundCell")
}

extension Theme.Font {
    static let header: Font = Font.custom("lazy_dog", size: 25)
}

extension Theme.Constants {
    static let budget: Budget = Budget(
        id: "TestID",
        name: "Test Budget",
        intervalType: .monthly,
        defaultItems: [
            BudgetItem(
                name: "Food",
                maxValue: 100.00
            ),
            BudgetItem(
                name: "Entertainment",
                maxValue: 100.00
            ),
            BudgetItem(
                name: "Fuel",
                maxValue: 100.00
            )
        ],
        intervals: [
            BudgetInterval(
                startDateTime: Date(),
                endDateTime: Calendar.current.date(byAdding: .month, value: 1, to: Date()) ?? Date(),
                items: [
                    BudgetItem(
                        name: "Food",
                        maxValue: 100.00,
                        items: [
                            ExpenseItem(name: "Coles", amount: 45.0, date: Date()),
                            ExpenseItem(name: "McDonalds", amount: 5.0, date: Date())
                        ]
                    ),
                    BudgetItem(
                        name: "Entertainment",
                        maxValue: 100.00,
                        items: [
                            ExpenseItem(name: "Movies", amount: 50.0, date: Date()),
                            ExpenseItem(name: "Mini golf", amount: 40.0, date: Date())
                        ]
                    ),
                    BudgetItem(
                        name: "Fuel",
                        maxValue: 100.00,
                        items: [
                            ExpenseItem(name: "BP", amount: 105.0, date: Date())
                        ]
                    )
                ]
            )
        ],
        oneOff: true,
        isActive: true
    )
    
    static let budgets: [Budget] = [
        budget,
        Budget(
            id: "TestID",
            name: "Test Budget - old",
            intervalType: .monthly,
            defaultItems: [
                BudgetItem(
                    name: "Test Item",
                    maxValue: 100.00
                )
            ],
            intervals: [
                BudgetInterval(
                    startDateTime: Calendar.current.date(byAdding: .month, value: -5, to: Date()) ?? Date(),
                    endDateTime: Calendar.current.date(byAdding: .month, value: -4, to: Date()) ?? Date(),
                    items: [
                        BudgetItem(
                            name: "Food",
                            maxValue: 100.00,
                            items: []
                        ),
                        BudgetItem(
                            name: "Entertainment",
                            maxValue: 100.00,
                            items: []
                        ),
                        BudgetItem(
                            name: "Fuel",
                            maxValue: 100.00,
                            items: []
                        )
                    ]
                )
            ],
            oneOff: true,
            isActive: false
        )
    ]
}
