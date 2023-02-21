//
//  BudgetHistoryView.swift
//  friendly-spork
//
//  Created by James on 18/2/2023.
//

import SwiftUI

struct BudgetHistoryView: View {
    let budget: Budget
    private var intervals: [BudgetInterval] {
        budget
            .intervals
            .sorted(by: { $0.startDateTime > $1.startDateTime })
    }
    private var totalAmount: Double { budget.currentInterval?.totalAmount ?? 0.0 }
    private var maxAmount: Double { budget.currentInterval?.maxAmount ?? 0.0 }
    
    @State var currentInterval: BudgetInterval!
    @State var showingSheet: Bool = false
    
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
                    Text("Budget history")
                        .font(.system(size: 40, weight: .heavy))
                        .foregroundColor(Theme.Color.textHard)
                        .padding(.leading, 20)
                    
                    Spacer()
                }
                .padding(.top, 100)
                
                VStack {
                    ScrollView {
                        VStack {
                            ForEach(intervals, id: \.self) { interval in
                                VStack {
                                    
                                    
                                    VStack {
                                        Button {
                                            showingSheet.toggle()
                                        } label: {
                                            HStack {
                                                VStack(alignment: .leading) {
                                                    HStack {
                                                        VStack(alignment: .leading) {
                                                            Text(interval.intervalTitle)
                                                                .font(.system(size: 16))
                                                                .foregroundColor(Theme.Color.text)
                                                                .bold()
                                                                .padding(.bottom, 2)
                                                            
                                                            Text(interval.amountString)
                                                                .font(.system(size: 25))
                                                                .foregroundColor(Theme.Color.text)
                                                        }
                                                        
                                                        Spacer()
                                                        
                                                        Text(String(format: "%.0f", (totalAmount / maxAmount) * 100) + "%")
                                                            .font(.system(size: 35, weight: .bold))
                                                            .foregroundColor(Theme.Color.text)
                                                    }
                                                    
                                                    ProgressBarView(
                                                        totalAmount: totalAmount,
                                                        maxAmount: maxAmount
                                                    )
                                                }
                                            }
                                            .padding()
                                            .background(Theme.Color.teal.opacity(0.2))
                                            .cornerRadius(10)
                                        }
                                        .sheet(isPresented: $showingSheet) {
                                            SpendHistoryView(budgetItems: interval.items, showClose: true)
                                        }
                                        .padding([.leading, .trailing], 10)
                                    }
                                    .padding(.vertical, 15)
                                }
                            }
                        }
                        .cornerRadius(10)
                        .padding()
                    }
                    .background(Theme.Color.background)
                    .cornerRadius(15, corners: [.topLeft, .topRight])
                }
            }
        }
    }
}

struct BudgetHistoryView_Previews: PreviewProvider {
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
            ),
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
    )
    
    static var previews: some View {
        BudgetHistoryView(budget: budget)
    }
}
