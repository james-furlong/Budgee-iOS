//
//  BudgetView.swift
//  friendly-spork
//
//  Created by James on 4/2/2023.
//

import SwiftUI

struct BudgetView: View {
    @State var budget: Budget
    @State var budgetItems: [BudgetItem]
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(budget: Budget, budgetItems: [BudgetItem]) {
        self.budget = budget
        self.budgetItems = budgetItems
    }
    
    var body: some View {
        ZStack {
            Theme.Color.background.ignoresSafeArea()
            VStack {
                Image("home-background")
                    .resizable()
                    .ignoresSafeArea()
                    .frame(height: 250)
                
                Spacer()
            }
            
            VStack(spacing: 10) {
                HStack {
                    Text(budget.name)
                        .font(.system(size: 40, weight: .heavy))
                        .foregroundColor(Theme.Color.textHard)
                        .padding(.leading, 20)
                    
                    Spacer()
                }
                .padding(.top, 100)
                
                VStack {
                    BudgetCircleChart(budget: budget)
                        .padding([.leading, .trailing], 80)
                    
                    GeometryReader { geo in
                        ScrollView {
                            VStack(spacing: 5) {
                                LazyVGrid(columns: columns, spacing: geo.size.width / 2.5) {
                                    ForEach(budgetItems.indices, id: \.self) { i in
                                        BudgetItemCellView(item: self.$budgetItems[i])
                                    }
                                }
                                .padding([.trailing, .leading], 15)
                            }
                        }
                    }
                    .padding(.top, -80)
                    .padding(.bottom, 50)
                }
                .background(Theme.Color.background)
                .cornerRadius(15, corners: [.topLeft, .topRight])
            }
        }
    }
}

struct BudgetView_Previews: PreviewProvider {
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
        BudgetView(budget: budget, budgetItems: budget.currentInterval?.items ?? [])
    }
}
