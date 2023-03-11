//
//  BudgetCellView.swift
//  friendly-spork
//
//  Created by James on 7/2/2023.
//

import SwiftUI

struct BudgetCellView: View {
    let budget: Budget
    
    private var textColor: Color {
        return budget.isActive ? Theme.Color.textHardSupp : Theme.Color.textHardSupp.opacity(0.4)
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text(budget.name)
                    .font(.system(size: 35))
                    .bold()
                    .foregroundColor(textColor)

                
                Spacer()
            }
            .padding([.leading, .trailing, .top], 20)

            
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(budget.intervalType.name)
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(textColor)
                        .padding(.leading, 20)
                    
                    Text(budget.expenseCountTitle)
                        .font(.system(size: 18))
                        .foregroundColor(textColor)
                        .padding([.leading, .bottom], 20)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 20))
                    .foregroundColor(textColor)
                    .padding()
            }
        }
        .background(budget.isActive ? Theme.Color.teal100 : Theme.Color.teal40)
        .cornerRadius(20)
        .padding()
    }
}

struct BudgetCellView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetCellView(budget: Theme.Constants.budget)
    }
}
