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
                Image("home-background")
                    .resizable()
                    .ignoresSafeArea()
                    .frame(height: 250)
                
                Spacer()
            }
            
            VStack(spacing: 10) {
                HStack {
                    Text("Budgee")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(Theme.Color.textHard)
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    if !budgets.isEmpty {
                        Button {
                            addBudgetShowing = true
                        } label: {
                            Image(systemName: "plus.circle")
                                .font(.system(size: 35))
                                .foregroundColor(Theme.Color.textHard)
                        }
                        .padding()
                    }
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    if budgets.isEmpty {
                        Spacer()
                        
                        HStack {
                            Spacer ()
                            
                            Button {
                                addBudgetShowing = true
                            } label: {
                                Text("Add initital budget")
                                    .font(.system(size: 25))
                                    .foregroundColor(Theme.Color.textSupp)
                                    .padding([.leading, .trailing], 30)
                                    .padding()
                                    .background(Theme.Color.teal)
                                    .cornerRadius(20)
                            }
                            
                            Spacer()
                        }
                        
                        Spacer()
                    }
                    
                    if !budgets.filter { $0.isActive }.isEmpty {
                        Text("Active budgets")
                            .font(.system(size: 16))
                            .foregroundColor(Theme.Color.text)
                            .padding(.leading, 20)
                            .padding(.bottom, -10)
                        
                        ForEach(budgets.filter { $0.isActive }, id: \.self) { budget in
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
                    
                    if !budgets.filter { !$0.isActive }.isEmpty {
                        Text("Inactive budgets")
                            .font(.system(size: 16))
                            .foregroundColor(Theme.Color.text)
                            .padding(.leading, 20)
                            .padding(.bottom, -10)
                        
                        ForEach(budgets.filter { !$0.isActive }, id: \.self) { budget in
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
                    
                    Spacer()
                }
                .padding(.top, 30)
                .background(Theme.Color.background)
                .cornerRadius(15, corners: [.topLeft, .topRight])
            }
            
            VStack {
                if addBudgetShowing {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .transition(.opacity)
                }
            }
            .animation(.default, value: addBudgetShowing)
            .onTapGesture {
                addBudgetShowing = false
            }
            
            VStack {
                if addBudgetShowing {
                    AddBudgetView {
                        addBudgetShowing = false
                        budgets = Injector.fileManager.retrieveBudgets()
                    }
                    .padding(.top, 50)
                    .ignoresSafeArea(edges: .bottom)
                    .transition(.move(edge: .bottom))
                }
            }
            .animation(.default, value: addBudgetShowing)
            
            if budgetShowing {
                TabBarView() {
                    budgetShowing = false
                }.environmentObject(currentBudget)
            }
        }
    }
}

struct BudgetDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetDashboardView()
    }
}
