//
//  BudgetView.swift
//  friendly-spork
//
//  Created by James on 4/2/2023.
//

import SwiftUI

struct BudgetView: View {
    @State var budget: Budget
    @State var isShowingAddExpense: Bool = false
    let completion: () -> ()
    
    var body: some View {
        ZStack {
            Theme.Color.background.ignoresSafeArea()
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(budget.name)
                            .font(.system(size: 35))
                            .bold()
                            .foregroundColor(Theme.Color.text)
                            .padding(.leading, 20)
                        
                        Text(budget.statusTitle)
                            .font(.system(size: 20))
                            .foregroundColor(Theme.Color.text)
                            .multilineTextAlignment(.leading)
                            .padding(.leading, 20)
                    }
                    
                    Spacer()
                    
                    Button {
                        completion()
                    } label: {
                        Image(systemName: "multiply")
                            .font(.system(size: 35))
                            .foregroundColor(Theme.Color.red)
                    }
                    .padding()
                }
                
                ForEach(budget.currentInterval?.items ?? [], id: \.self) { item in
                    BudgetItemCellView(item: item)
                }
                
                Spacer()
            }
            
            VStack {
                Spacer()
                
                Button {
                    isShowingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 25))
                        .bold()
                        .foregroundColor(Theme.Color.textHard)
                }
                .padding([.leading, .trailing])
                .padding()
                .background(Theme.Color.green)
                .clipShape(Capsule())
            }
            
            if isShowingAddExpense {
                AddSpendItemView(budget: budget) {
                    do {
                        try Injector.fileManager.saveOrUpdateBudget(budget: budget)
                    }
                    catch {
                        Injector.log.error("Unable to save spend item")
                    }
                    isShowingAddExpense = false
                }
            }
        }
    }
}

struct BudgetView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetView(budget: Budget(
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
                            name: "Test Item",
                            maxValue: 100.00
                        )
                    ]
                )
            ]
        )) { }
    }
}
