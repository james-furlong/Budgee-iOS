//
//  BudgetCellView.swift
//  friendly-spork
//
//  Created by James on 7/2/2023.
//

import SwiftUI

struct BudgetCellView: View {
    let budget: Budget
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                VStack(spacing: 5) {
                    Text(budget.name)
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(Theme.Color.textSupp)
                        .padding([.leading, .top], 20)
                    
                    
                    Text(budget.statusTitle)
                        .font(.system(size: 18))
                        .foregroundColor(Theme.Color.textSupp)
                        .padding([.leading, .bottom], 20)
                }
                
                Spacer()
                
                Image(systemName: "chevron.forward")
                    .font(.system(size: 30))
                    .foregroundColor(Theme.Color.textSupp)
                    .padding()
            }
            .background(budget.isUnderBudget ? Theme.Color.navy : Theme.Color.red)
            .cornerRadius(20)
            .padding()
        }
    }
}

struct BudgetCellView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetCellView(budget: Budget(
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
                            name: "Test Item",
                            maxValue: 100.00
                        )
                    ]
                )
            ],
            oneOff: true
        ))
    }
}