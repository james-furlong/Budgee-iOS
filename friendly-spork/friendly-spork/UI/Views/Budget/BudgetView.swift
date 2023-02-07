//
//  BudgetView.swift
//  friendly-spork
//
//  Created by James on 4/2/2023.
//

import SwiftUI

struct BudgetView: View {
    @State var budget: Budget
    let completion: () -> ()
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(budget.name)
                            .font(.system(size: 35))
                            .bold()
                            .foregroundColor(Color("Text"))
                            .padding(.leading, 20)
                        
                        Text(budget.statusTitle)
                            .font(.system(size: 20))
                            .foregroundColor(Color("Text"))
                            .multilineTextAlignment(.leading)
                            .padding(.leading, 20)
                    }
                    
                    Spacer()
                    
                    Button {
                        completion()
                    } label: {
                        Image(systemName: "multiply")
                            .font(.system(size: 35))
                            .foregroundColor(Theme.Color.green)
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
                    print("")
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 25))
                        .bold()
                        .foregroundColor(Theme.Color.textSupp)
                }
                .padding([.leading, .trailing])
                .padding()
                .background(Theme.Color.green)
                .clipShape(Capsule())
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
                    maximumValue: 100.00,
                    currentValue: 0.0
                )
            ],
            intervals: [
                BudgetInterval(
                    startDateTime: Date(),
                    endDateTime: Calendar.current.date(byAdding: .month, value: 1, to: Date()) ?? Date(),
                    items: [
                        BudgetItem(
                            name: "Test Item",
                            maximumValue: 100.00,
                            currentValue: 30.0
                        )
                    ]
                )
            ]
        )) { }
    }
}
