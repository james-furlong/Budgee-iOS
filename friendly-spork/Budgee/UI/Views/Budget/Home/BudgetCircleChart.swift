//
//  BudgetCircleChart.swift
//  friendly-spork
//
//  Created by James on 20/2/2023.
//

import SwiftUI

struct BudgetCircleChart: View {
    let budget: Budget
    private var percent: Double {
        let totalMax: Double = budget.currentInterval?.maxAmount ?? 0.0
        let totalCurrent: Double = budget.currentInterval?.totalAmount ?? 0.0
        return totalCurrent / totalMax
    }
    private var endAngle: Double {
        return 220 * percent
    }
    private var usedPercent: String {
        return String(format: "%.0f", percent * 100) + "%"
    }
    
    var body: some View {
        ZStack {
            Arc(startAngle: .degrees(0), endAngle: .degrees(220), clockwise: true)
                .stroke(
                    Theme.Color.teal20,
                    style: StrokeStyle(lineWidth: 30, lineCap: .round)
                )
                .padding()
            
            Arc(startAngle: .degrees(0), endAngle: .degrees(endAngle), clockwise: true)
                .stroke(
                    Theme.Color.teal100,
                    style: StrokeStyle(lineWidth: 30, lineCap: .round)
                )
                .padding()
            
            VStack {
                Text(usedPercent)
                    .font(.system(size: 40, weight: .heavy))
                
                Text("used")
                    .font(.system(size: 20, weight: .semibold))
            }
        }
    }
}

struct BudgetCircleChart_Previews: PreviewProvider {
    static let budget = Budget(
        id: "TestID",
        name: "Test Budget",
        intervalType: .monthly,
        defaultItems: [
            BudgetItem(
                name: "Test Item",
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
                            ExpenseItem(name: "", amount: 50.0, date: Date())
                        ]
                    ),
                    BudgetItem(
                        name: "Entertainment",
                        maxValue: 100.00,
                        items: [
                            ExpenseItem(name: "", amount: 91.0, date: Date())
                        ]
                    ),
                    BudgetItem(
                        name: "Fuel",
                        maxValue: 100.00,
                        items: [
                            ExpenseItem(name: "", amount: 105.0, date: Date())
                        ]
                    )
                ]
            )
        ],
        oneOff: true
    )
    
    static var previews: some View {
        BudgetCircleChart(budget: budget)
    }
}
