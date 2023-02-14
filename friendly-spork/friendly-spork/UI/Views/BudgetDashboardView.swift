//
//  BudgetDashboardView.swift
//  friendly-spork
//
//  Created by James on 4/2/2023.
//

import SwiftUI

struct BudgetDashboardView: View {
    @State var budgets = Injector.fileManager.retrieveBudgets()
    @State var currentBudget: Budget!
    @State var budgetShowing: Bool = false
    @State var addBudgetShowing: Bool = false
    
    var body: some View {
        ZStack {
            Theme.Color.background.ignoresSafeArea()
            VStack {
                VStack(spacing: 0) {
                    HStack {
                        Text("Budgets")
                            .font(.system(size: 35))
                            .bold()
                            .foregroundColor(Theme.Color.text)
                            .padding(.leading, 20)
                        
                        Spacer()
                        
                        Button {
                            addBudgetShowing = true
                        } label: {
                            Image(systemName: "plus.circle")
                                .font(.system(size: 35))
                                .foregroundColor(Theme.Color.green)
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
                    
                    Spacer()
                }
            }
            
            if budgets.isEmpty {
                Button {
                    addBudgetShowing = true
                } label: {
                    Text("Add initital budget")
                        .font(.system(size: 25))
                        .foregroundColor(Theme.Color.textSupp)
                        .padding([.leading, .trailing], 30)
                        .padding()
                        .background(Theme.Color.green)
                        .cornerRadius(20)
                }
            }
            
            if addBudgetShowing {
                AddBudgetView {
                    addBudgetShowing = false
                    budgets = Injector.fileManager.retrieveBudgets()
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
