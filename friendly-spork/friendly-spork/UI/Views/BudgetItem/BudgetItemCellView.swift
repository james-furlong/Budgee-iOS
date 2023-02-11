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
                Rectangle()
                    .frame(height: 40)
                    .foregroundColor(.black.opacity(0.1))
                    .clipShape(Capsule())
                
                Rectangle()
                    .frame(height: 40, alignment: .leading)
                    .foregroundColor(item.progressBarColor)
                    .padding([.trailing], item.progressWidthPadding(geoWidth: geo.size.width))
                    .clipShape(Capsule())
                
                HStack(alignment: .top) {
                    Text(item.name)
                        .bold()
                        .foregroundColor(item.progressTextColor)
                        .padding([.leading], 15)
                    
                    Spacer()
                    
                    Text(item.currentAmount)
                        .bold()
                        .foregroundColor(item.progressTextColor)
                        .padding([.trailing], 15)
                }
            }
        }
        .frame(height: 40)
        .padding([.leading, .trailing])
    }
}

struct BudgetItemCellView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetItemCellView(item: BudgetItem(
            name: "Test Item",
            maxValue: 100.00,
            items: [
                ExpenseItem(name: "Test", amount: 89.0)
            ]
        ))
    }
}
