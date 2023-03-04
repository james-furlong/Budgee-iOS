//
//  SpendHistoryView.swift
//  friendly-spork
//
//  Created by James on 17/2/2023.
//

import SwiftUI

struct SpendHistoryView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var budget: Budget
    var showClose: Bool = false
    
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
                    Text("Spend history")
                        .font(.system(size: 40, weight: .heavy))
                        .foregroundColor(Theme.Color.textHard)
                        .padding(.leading, 20)
                    
                    Spacer()
                }
                .padding(.top, 20)
                
                VStack {
                    ScrollView {
                        ForEach(budget.currentInterval?.items ?? [], id: \.self) { item in
                            SpendHistoryCell(budgetItem: item) { _ in }
                                .padding(.bottom, -20)
                        }
                        .padding(.bottom, 10)
                    }
                    .padding(.bottom)
                }
                .background(Theme.Color.background)
                .cornerRadius(15, corners: [.topLeft, .topRight])
            }
        }
    }
}

struct SpendHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        SpendHistoryView(budget: Theme.Constants.budget)
    }
}
