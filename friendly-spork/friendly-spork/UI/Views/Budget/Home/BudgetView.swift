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
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(budget: Budget, budgetItems: [BudgetItem]) {
        self.budget = budget
        self.budgetItems = budgetItems
    }
    
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
                    Text(budget.name)
                        .font(.system(size: 40, weight: .heavy))
                        .foregroundColor(Theme.Color.textHard)
                        .padding(.leading, 20)
                    
                    Spacer()
                }
                .padding(.top, 100)
                
                VStack {
                    BudgetCircleChart(budget: budget)
                        .padding([.leading, .trailing], 80)
                    
                    GeometryReader { geo in
                        ScrollView {
                            VStack(spacing: 5) {
                                LazyVGrid(columns: columns, spacing: geo.size.width / 2.5) {
                                    ForEach(budgetItems.indices, id: \.self) { i in
                                        BudgetItemCellView(item: self.$budgetItems[i])
                                    }
                                }
                                .padding([.trailing, .leading], 15)
                            }
                        }
                    }
                    .padding(.top, -80)
                    .padding(.bottom, 50)
                }
                .background(Theme.Color.background)
                .cornerRadius(15, corners: [.topLeft, .topRight])
            }
        }
    }
}

struct BudgetView_Previews: PreviewProvider {
    static let budget = Theme.Constants.budget
    
    static var previews: some View {
        BudgetView(budget: budget, budgetItems: budget.currentInterval?.items ?? [])
    }
}
