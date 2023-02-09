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
        ZStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.system(size: 25))
                    .bold()
                    .foregroundColor(Theme.Color.text)
                    .padding([.leading, .top], 20)
                
                ProgressView("", value: item.currentValue, total: item.maximumValue)
                    .font(.system(size: 20))
                    .foregroundColor(Theme.Color.text)
                    .tint(item.isUnderBudget ? Theme.Color.green : Theme.Color.red)
                    .padding([.leading, .bottom, .trailing], 20)
            }
        }
        .background(Theme.Color.colorArray.randomElement()?.opacity(0.2))
        .cornerRadius(20)
        .padding()
    }
}

struct BudgetItemCellView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetItemCellView(item: BudgetItem(
            name: "Test Item",
            maxValue: 100.00
        ))
    }
}
