//
//  SpendHistoryView.swift
//  friendly-spork
//
//  Created by James on 17/2/2023.
//

import SwiftUI

struct SpendHistoryView: View {
    @Environment(\.dismiss) var dismiss
    @State var budgetItems: [BudgetItem]
    var showClose: Bool = false
    
    
    init(budgetItems: [BudgetItem], showClose: Bool = false) {
        _budgetItems = State(initialValue: budgetItems)
        self.showClose = showClose
    }
    
    var body: some View {
        ZStack {
            Theme.Color.background.ignoresSafeArea()
            VStack {
                HStack {
                    Text("Spend history")
                        .font(.system(size: 35))
                        .bold()
                        .foregroundColor(Theme.Color.text)
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    if showClose {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.down")
                                .font(.system(size: 25, weight: .semibold))
                                .foregroundColor(Theme.Color.navy)
                        }
                        .padding(.trailing)
                    }
                }
                .padding(.top, 20)
                
                VStack(spacing: 5) {
                    ScrollView {
                        ForEach(budgetItems, id: \.self) { item in
                            SpendHistoryCell(budgetItem: item) { _ in }
                                .padding(.bottom, 20)
                        }
                        .padding(.bottom, 10)
                    }
                    .padding(.bottom)
                }
                .cornerRadius(10)
                .padding()
                
                Spacer()
            }
        }
    }
}

struct SpendHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        SpendHistoryView(budgetItems: [
            BudgetItem(
                name: "Fuel",
                maxValue: 200.00,
                items: [
                    ExpenseItem(
                        name: "BP",
                        amount: 50.00,
                        date: Date()
                    ),
                    ExpenseItem(
                        name: "Shell",
                        amount: 75.00,
                        date: Date()
                    )
                ]
            ),
            BudgetItem(
                name: "Food",
                maxValue: 200.00,
                items: [
                    ExpenseItem(
                        name: "Woolworths",
                        amount: 150.00,
                        date: Date()
                    ),
                    ExpenseItem(
                        name: "Coles",
                        amount: 25.00,
                        date: Date()
                    )
                ]
            )
        ],
        showClose: true)
    }
}
