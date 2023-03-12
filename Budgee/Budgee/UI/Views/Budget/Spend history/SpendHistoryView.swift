//
//  SpendHistoryView.swift
//  friendly-spork
//
//  Created by James on 17/2/2023.
//

import SwiftUI

struct SpendHistoryView: View {
    @ObservedObject var budget: Budget
    @State var detailViewShowing: Bool = false
    @State var transactionDetail: ExpenseItem?
    
    let isSheet: Bool
    private let completion: () -> ()
    
    init(budget: Budget, isSheet: Bool = false, completion: @escaping () -> ()) {
        self.budget = budget
        self.isSheet = isSheet
        self.completion = completion
    }
    
    private func updateDetail(_ item: ExpenseItem) {
        self.transactionDetail = item
    }
    
    var body: some View {
        ZStack {
            if !isSheet {
                BackgroundView()
            }
            
            VStack(spacing: 10) {
                HStack {
                    Text(!isSheet ? "Spend history" : "")
                        .font(.system(size: 40, weight: .heavy))
                        .foregroundColor(Theme.Color.textHard)
                        .padding(.leading, 20)
                    
                    Spacer()
                }
                .padding(.top, 20)
                
                VStack {
                    HStack {
                        Spacer()
                        
                        Button {
                            completion()
                        } label: {
                            Image(systemName: "chevron.down")
                                .font(.system(size: 30))
                                .foregroundColor(Theme.Color.text)
                        }
                        .padding([.trailing, .top])
                    }
                    
                    ScrollView {
                        ForEach(budget.currentInterval?.items ?? [], id: \.self) { item in
                            SpendHistoryCell(budgetItem: item) { item in
                                updateDetail(item)
                                
                            }
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
        SpendHistoryView(budget: Theme.Constants.budget) { }
    }
}
