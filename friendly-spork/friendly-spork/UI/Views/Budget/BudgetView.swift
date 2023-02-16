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
    @State var isShowingAddExpense: Bool
    let completion: () -> ()
    
    init(budget: Budget, completion: @escaping () -> Void) {
        self.budget = budget
        self.budgetItems = budget.currentInterval?.items ?? []
        self.isShowingAddExpense = false
        self.completion = completion
    }
    
    var body: some View {
        ZStack {
            Theme.Color.background.ignoresSafeArea()
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(budget.name)
                            .font(.system(size: 35))
                            .bold()
                            .foregroundColor(Theme.Color.text)
                            .padding(.leading, 20)
                        
                        Text(budget.statusTitle)
                            .font(.system(size: 20))
                            .foregroundColor(Theme.Color.text)
                            .multilineTextAlignment(.leading)
                            .padding(.leading, 20)
                    }
                    
                    Spacer()
                    
                    Button {
                        completion()
                    } label: {
                        Image(systemName: "multiply")
                            .font(.system(size: 35, weight: .semibold))
                            .foregroundColor(Theme.Color.red)
                    }
                    .padding()
                }
                
                VStack(spacing: 5) {
                    HStack {
                        Text("Expenses")
                            .font(.system(size: 20))
                            .bold()
                            .foregroundColor(Theme.Color.text)
                            .padding()
                        
                        Spacer()
                    }
                    
                    VStack {
                        ForEach(budgetItems.indices, id: \.self) { i in
                            VStack {
                                BudgetItemCellView(item: self.$budgetItems[i])
                            }
                        }
                    }
                    .padding(.bottom)
                }
                .background(Theme.Color.backgroundSupp)
                .cornerRadius(10)
                .padding()
                
                Spacer()
            }
            
            VStack {
                Spacer()
                
                Button {
                    isShowingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 40, weight: .semibold))
                        .foregroundColor(Theme.Color.textHard)
                }
                .padding([.leading, .trailing])
                .padding()
                .background(Theme.Color.green)
                .clipShape(Circle())
            }
            
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

struct BudgetView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetView(budget: Budget(
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
                                ExpenseItem(name: "", amount: 45.0, date: Date())
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
        )) { }
    }
}
