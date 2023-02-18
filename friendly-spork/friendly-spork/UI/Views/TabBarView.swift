//
//  TabBarView.swift
//  friendly-spork
//
//  Created by James on 17/2/2023.
//

import SwiftUI

struct TabBarView: View {
    
    @State var budget: Budget
    @State var budgetItems: [BudgetItem]
    @State private var selectedTab: TabBarItem = .home
    @State var isShowingAddExpense: Bool
    
    let completion: () -> ()
    
    init(budget: Budget, completion: @escaping () -> Void) {
        self.budget = budget
        self.budgetItems = budget.currentInterval?.items ?? []
        self.isShowingAddExpense = false
        self.completion = completion
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $selectedTab) {
                BudgetView(budget: budget, budgetItems: budgetItems)
                    .tag(TabBarItem.home)
                
                SpendHistoryView(budgetItems: budgetItems)
                    .tag(TabBarItem.spendHistory)
                
                Color(.green)
                    .ignoresSafeArea(.all, edges: .all)
                    .tag(TabBarItem.add)
                
                BudgetHistoryView(budget: budget)
                    .tag(TabBarItem.budgetHistory)
                
                SettingsView() { completion() }
                    .tag(TabBarItem.settings)
            }
            
            HStack(spacing: 0) {
                ForEach(TabBarItem.allCases, id: \.self) { item in
                    GeometryReader { geo in
                        Button {
                            selectedTab = item
                        } label: {
                            item.icon
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25.0, height: 25.0)
                                .foregroundColor(selectedTab == item ? Theme.Color.green : Theme.Color.blue)
                                .padding(10)
                                .offset(x: -10, y: -5)
                        }
                    }
                    .frame(width: 25.0, height: 30.0)
                    .padding(.bottom, 5)
                    
                    if item != TabBarItem.allCases.last {
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical)
            .background(Theme.Color.backgroundSupp)
            .cornerRadius(30)
            .padding(.horizontal, 50)
            .padding(.vertical, 10)
            
            if isShowingAddExpense {
                Color.black.opacity(0.6).ignoresSafeArea()
            }
            
            if isShowingAddExpense {
                AddSpendItemView(budget: budget) {
                    let budgetId = budget.id
                    if let newBudget = Injector.fileManager.retrieveBudgets().first(where: { $0.id == budgetId }) {
                        budget = newBudget
                        budgetItems = newBudget.currentInterval?.items ?? []
                    }
                    isShowingAddExpense = false
                }
            }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(budget: Budget(
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
            oneOff: true
        )) { }
    }
}
