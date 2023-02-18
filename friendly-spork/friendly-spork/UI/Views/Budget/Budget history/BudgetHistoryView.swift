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
    @State var currentInterval: BudgetInterval!
    @State var showingSheet: Bool = false
    
    var body: some View {
        ZStack {
            Theme.Color.background.ignoresSafeArea()
            VStack {
                HStack {
                    Text("Budget history")
                        .font(.system(size: 35))
                        .bold()
                        .foregroundColor(Theme.Color.text)
                        .padding(.leading, 20)
                    
                    Spacer()
                }
                .padding(.top, 20)
                
                ScrollView {
                    VStack {
                        ForEach(intervals, id: \.self) { interval in
                            VStack {
                                HStack {
                                    Text(interval.intervalTitle)
                                        .font(.system(size: 16))
                                        .bold()
                                        .padding([.top, .leading])
                                    
                                    Spacer()
                                }
                                .padding(.bottom, -5)
                                
                                VStack {
                                    Button { } label: {
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text(interval.amountString)
                                                    .font(.system(size: 25))
                                                    .foregroundColor(Theme.Color.textHardSupp)
                                            }
                                            
                                            Spacer()
                                            
                                            Image(systemName: "chevron.right")
                                                .font(.system(size: 20, weight: .bold))
                                                .foregroundColor(Theme.Color.textHardSupp)
                                        }
                                        .padding()
                                        .background(Theme.Color.navy)
                                        .cornerRadius(10)
                                    }
                                    .sheet(isPresented: $showingSheet) {
                                        SpendHistoryView(budgetItems: interval.items)
                                    }
                                    .padding([.leading, .trailing])
                                }
                                .padding(.bottom, 25)
                            }
                        }
                    }
                    .background(Theme.Color.backgroundSupp)
                    .cornerRadius(10)
                    .padding()
                }
                
                Spacer()
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
