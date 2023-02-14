//
//  AddSpendItemView.swift
//  friendly-spork
//
//  Created by James on 8/2/2023.
//

import SwiftUI

struct AddSpendItemView: View {
    let budget: Budget
    @State private var name: String = ""
    @State private var amount: Double? = nil
    @State private var itemId: String = ""
    let completion: () -> ()
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                VStack {
                    VStack {
                        TextField("Name", text: $name)
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
                    
                    HStack {
                        Text("Select expense type")
                            .font(.system(size: 16))
                            .foregroundColor(.black.opacity(0.7))
                        
                        Spacer()
                    }
                    .padding([.leading, .trailing, .top], 20)
                    
                    
                    VStack {
                        ForEach(budget.defaultItems, id: \.id) { item in
                            Button {
                                itemId = item.id
                            } label: {
                                HStack {
                                    Text(item.name)
                                        .font(.system(size: 25))
                                        .foregroundColor(Theme.Color.text)
                                        .tag(item as BudgetItem)
                                    
                                    Spacer()
                                    
                                    if item.id == itemId {
                                        Image(systemName: "checkmark.seal.fill")
                                            .font(.system(size: 20))
                                            .foregroundColor(Theme.Color.yellow)
                                    }
                                }
                            }
                            .padding()
                            .background(Theme.Color.blue.opacity(0.6))
                        }
                    }
                    .background()
                    .cornerRadius(20)
                    .padding([.leading, .trailing], 15)
                }
                .cornerRadius(10)
                .padding(.bottom, 20)

                Button {
                    if let amount = amount {
                        budget.addSpendItem(
                            item: ExpenseItem(
                                name: name,
                                amount: amount
                            ),
                            itemId: itemId
                        )
                        
                        do {
                            try Injector.fileManager.saveOrUpdateBudget(budget: budget)
                        }
                        catch {
                            Injector.log.error("Could not save expense item")
                        }
                    }
                    completion()
                } label: {
                    Text("Add")
                        .font(.system(size: 16))
                        .bold()
                        .foregroundColor(Theme.Color.text)
                }
                .padding([.leading, .trailing], 40)
                .padding([.top, .bottom])
                .background(Theme.Color.green)
                .clipShape(Capsule())
            }
            .padding(.bottom, 20)
        }
        .background(Theme.Color.backgroundSupp)
        .cornerRadius(20)
        .padding()
    }
}

struct AddSpendItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddSpendItemView(
            budget: Budget(
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
            )
        ) { }
    }
}
