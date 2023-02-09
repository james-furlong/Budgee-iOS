//
//  BudgetDashboardView.swift
//  friendly-spork
//
//  Created by James on 4/2/2023.
//

import SwiftUI

struct BudgetDashboardView: View {
    @State var budgets = [
        Budget(
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
            ]
        )
    ]
//    @State var budgets = Injector.fileManager.retrieveBudgets()
    @State var currentBudget: Budget!
    @State var budgetShowing: Bool = false
    @State var addBudgetShowing: Bool = false
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            VStack {
                VStack(spacing: 0) {
                    HStack {
                        Text("Budgets")
                            .font(.system(size: 35))
                            .bold()
                            .foregroundColor(Color("Text"))
                            .padding(.leading, 20)
                        
                        Spacer()
                        
                        Button {
                            addBudgetShowing = true
                        } label: {
                            Image(systemName: "plus.circle")
                                .font(.system(size: 35))
                                .foregroundColor(Color("Green"))
                        }
                        .padding()
                    }
                    
                    ForEach(budgets, id: \.self) { budget in
                        BudgetCellView(budget: budget)
                            .gesture(
                                TapGesture()
                                    .onEnded {
                                        currentBudget = budget
                                        budgetShowing = true
                                    }
                            )
                    }
                }
            }
            
            if budgets.isEmpty {
                Button {
                    addBudgetShowing = true
                } label: {
                    Text("Add initital budget")
                        .font(.system(size: 25))
                        .foregroundColor(Color("TextSupp"))
                        .padding([.leading, .trailing], 30)
                        .padding()
                        .background(Color("Green"))
                        .cornerRadius(20)
                }
            }
            
            if addBudgetShowing {
                AddBudgetView {
                    addBudgetShowing = false
                }
                .transition(.slide)
            }
            
            if budgetShowing {
                BudgetView(budget: currentBudget) {
                    budgetShowing = false
                }
            }
        }
    }
}

struct BudgetDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetDashboardView()
    }
}
