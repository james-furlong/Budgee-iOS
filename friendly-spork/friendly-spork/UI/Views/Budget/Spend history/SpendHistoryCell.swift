//
//  SpendHistoryCell.swift
//  friendly-spork
//
//  Created by James on 17/2/2023.
//

import SwiftUI

struct SpendHistoryCell: View {
    let budgetItem: BudgetItem
    let completion: (ExpenseItem) -> ()
    
    var body: some View {
        VStack {
            HStack {
                Text(budgetItem.name)
                    .font(.system(size: 16))
                    .bold()
                    .padding([.top, .leading])
                
                Spacer()
            }
            .padding(.bottom, -5)
            
            VStack {
                ForEach(budgetItem.expenseItems, id: \.self) { item in
                    Button {
                        completion(item)
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.system(size: 25))
                                    .foregroundColor(Theme.Color.textHardSupp)
                                
                                Text(item.dateString)
                                    .font(.system(size: 16, weight: .light))
                                    .foregroundColor(Theme.Color.textHardSupp)
                            }
                            
                            Spacer()
                            
                            Text(String(format: "%.2f", item.amount))
                                .font(.system(size: 30, weight: .heavy))
                                .foregroundColor(Theme.Color.textHardSupp)
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Theme.Color.textHardSupp)
                        }
                        .padding()
                        .background(Theme.Color.navy)
                        .cornerRadius(10)
                    }
                }
                .padding([.leading, .trailing])
            }
            .padding(.bottom, 25)
        }
        .background(Theme.Color.backgroundSupp)
        .cornerRadius(10)
    }
}

struct SpendHistoryCell_Previews: PreviewProvider {
    static var previews: some View {
        SpendHistoryCell(budgetItem: BudgetItem(
            name: "Fuel",
            maxValue: 200.00,
            items: [
                ExpenseItem(name: "BP", amount: 20.00, date: Date()),
                ExpenseItem(name: "Shell", amount: 50.00, date: Date())
            ]
        )) { _ in }
    }
}
