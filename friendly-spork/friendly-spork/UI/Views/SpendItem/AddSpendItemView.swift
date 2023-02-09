//
//  AddSpendItemView.swift
//  friendly-spork
//
//  Created by James on 8/2/2023.
//

import SwiftUI

struct AddSpendItemView: View {
    let budget: Budget
    let completion: () -> ()
    
    @State private var name: String? = nil
    @State private var amount: Double? = nil
    @State private var item: BudgetItem? = nil
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                VStack {
                    VStack {
                        TextField("Name", value: $amount, format: .number)
                            .font(.system(size: 20))
                            .foregroundColor(Theme.Color.text)
                            .padding()
                    }
                    .background()
                    .cornerRadius(10)
                    .padding([.leading, .trailing, .top], 20)
                    
                    VStack {
                        TextField("Amount", value: $amount, format: .number)
                            .font(.system(size: 20))
                            .foregroundColor(Theme.Color.text)
                            .keyboardType(.numberPad)
                            .padding()
                    }
                    .background()
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 20)
                    
                    Menu {
                        Picker(selection: $item) {
                            ForEach(budget.defaultItems, id: \.self) { item in
                                Text(item.name)
                                    .font(.system(size: 40))
                                    .foregroundColor(Color("Text"))
                                    .tag(item as BudgetItem)
                            }
                        } label: { }
                    } label: {
                        HStack {
                            Text("Expense")
                                .font(.system(size: 20))
                                .foregroundColor(Color("Text"))
                                .padding()
                            
                            Spacer()
                            
                            if item == nil {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 20))
                                    .foregroundColor(Theme.Color.text)
                                    .padding()
                            }
                            else {
                                Text(item?.name ?? "")
                                    .font(.system(size: 20))
                                    .foregroundColor(Theme.Color.text)
                                    .padding()
                            }
                        }
                    }
                    .background()
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 20)
                }
                .cornerRadius(10)
                .padding(.bottom, 20)

                Button {
                    if let name = name, let amount = amount {
                        budget
                            .currentInterval?.items
                            .first(where: { $0.id == item?.id })?
                            .addExpense(ExpenseItem(
                                name: name,
                                amount: amount
                            ))
                    }
                    completion()
                } label: {
                    Text("Add")
                        .font(.system(size: 16))
                        .bold()
                        .foregroundColor(Color("Text"))
                }
                .padding([.leading, .trailing], 40)
                .padding([.top, .bottom])
                .background(Color("Sage"))
                .clipShape(Capsule())
            }
            .padding(.bottom, 20)
        }
        .background(Color("BackgroundSupp"))
        .cornerRadius(20)
        .padding()
    }
}

struct AddSpendItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddSpendItemView(budget: Budget(
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
