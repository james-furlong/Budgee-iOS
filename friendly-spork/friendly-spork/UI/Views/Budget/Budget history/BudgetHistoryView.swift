//
//  BudgetHistoryView.swift
//  friendly-spork
//
//  Created by James on 18/2/2023.
//

import SwiftUI

struct BudgetHistoryView: View {
    @ObservedObject var budget: Budget
    
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
                .padding(.top, 20)
                
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
            
            VStack {
                if showingSheet {
                    Color.black.opacity(0.2).ignoresSafeArea()
                        .transition(.opacity)
                }
            }
            .animation(.default, value: showingSheet)
            
            VStack {
                if showingSheet {
                    SpendHistoryView(budget: budget, isSheet: true) {
                        self.showingSheet = false
                    }
                    .ignoresSafeArea(edges: .bottom)
                    .transition(.move(edge: .bottom))
                }
            }
            .animation(.default, value: showingSheet)
        }
    }
}

struct BudgetHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetHistoryView(budget: Theme.Constants.budget)
    }
}
