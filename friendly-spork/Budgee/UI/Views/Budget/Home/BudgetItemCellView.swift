//
//  BudgetItemCellView.swift
//  friendly-spork
//
//  Created by James on 7/2/2023.
//

import SwiftUI

struct BudgetItemCellView: View {
    let item: BudgetItem
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    ZStack {
                        Rectangle()
                            .frame(height: geo.size.width - 40)
                            .foregroundColor(Theme.Color.backgroundCell)
                        
                        HStack(alignment: .bottom) {
                            Rectangle()
                                .foregroundColor(item.progressBarColor)
                                .padding(.top, item.progressHeightPadding(geoHeight: geo.size.width - 40))
                        }
                        .frame(height: geo.size.width - 40)
                        
                        VStack {
                            HStack{
                                Spacer()
                                
                                Text(item.progressPercent)
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(Theme.Color.text)
                            }
                            .padding()
                            
                            Spacer()

                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.remainingAmount)
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(Theme.Color.text)
                                    
                                    Text(item.name)
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundColor(Theme.Color.text)
                                }
                                
                                Spacer()
                            }
                            .padding()
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding([.trailing, .leading], 10)
                    .frame(height: geo.size.width - 40)
                }
            }
        }
    }
}

struct BudgetItemCellView_Previews: PreviewProvider {
    @State static var budgetItem = BudgetItem(
        name: "Test Item",
        maxValue: 100.00,
        items: [
            ExpenseItem(name: "Test", amount: 25.0, date: Date())
        ]
    )
    
    static var previews: some View {
        BudgetItemCellView(item: self.budgetItem)
    }
}
