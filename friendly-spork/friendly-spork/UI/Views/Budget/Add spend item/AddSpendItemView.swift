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
    @State private var date: Date = Date()
    @State private var itemId: String = ""
    let completion: () -> ()
    
    private var buttonIsEnabled: Bool {
        return !name.isEmpty && amount != nil
    }
    
    private var buttonColor: Color {
        return buttonIsEnabled ? Theme.Color.teal : Theme.Color.teal.opacity(0.3)
    }
    
    var body: some View {
        ZStack {
            Theme.Color.background.ignoresSafeArea()
            VStack(spacing: 10) {
                VStack {
                    HStack {
                        Text("Add spend item")
                            .font(.system(size: 35))
                            .bold()
                            .foregroundColor(Theme.Color.text)
                            .padding(.leading, 20)
                        
                        Spacer()
                    }
                    .padding(.top, 20)
                    
                    VStack {
                        TextField("Name", text: $name)
                            .font(.system(size: 20))
                            .foregroundColor(Theme.Color.text)
                            .padding()
                    }
                    .background(Theme.Color.yellow.opacity(0.2))
                    .cornerRadius(10)
                    .padding([.leading, .trailing, .top], 20)
                    
                    VStack {
                        TextField("Amount", value: $amount, format: .number)
                            .font(.system(size: 20))
                            .foregroundColor(Theme.Color.text)
                            .keyboardType(.numberPad)
                            .padding()
                    }
                    .background(Theme.Color.yellow.opacity(0.2))
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 20)
                    
                    VStack {
                        HStack {
                            DatePicker(selection: $date, in: ...Date.now, displayedComponents: .date) {
                                HStack {
                                    Text("Date")
                                        .font(.system(size: 20))
                                        .foregroundColor(Theme.Color.text)
                                        .padding()
                                }
                            }
                            .datePickerStyle(.compact)
                            .accentColor(Theme.Color.teal)
                        }
                        .padding(.trailing, 10)
                    }
                    .background(Theme.Color.yellow.opacity(0.2))
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 20)
                    
                    HStack {
                        Text("Select expense type")
                            .font(.system(size: 16))
                            .foregroundColor(.black.opacity(0.7))
                        
                        Spacer()
                    }
                    .padding([.leading, .trailing, .top], 20)
                    
                    
                    ScrollView {
                        ForEach(budget.defaultItems, id: \.id) { item in
                            VStack {
                                Button {
                                    itemId = item.id
                                } label: {
                                    HStack {
                                        Text(item.name)
                                            .font(.system(size: 18))
                                            .foregroundColor(Theme.Color.text)
                                            .tag(item as BudgetItem)
                                        
                                        Spacer()
                                        
                                        Image(systemName: item.id == itemId ? "circle.fill" : "circle")
                                            .font(.system(size: 20))
                                            .foregroundColor(Theme.Color.teal)
                                    }
                                }
                                .padding()
                                .background(Theme.Color.orange.opacity(0.6))
                                .cornerRadius(30)
                            }
                            .padding([.leading, .trailing], 20)
                        }
                    }
                    .frame(height: 200)
                    
                    Button {
                        if let amount = amount {
                            budget.addSpendItem(
                                item: ExpenseItem(
                                    name: name,
                                    amount: amount,
                                    date: date
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
                            .padding([.leading, .trailing], 40)
                            .padding([.top, .bottom])
                            .background(buttonColor)
                            .clipShape(Capsule())
                    }
                    .disabled(!buttonIsEnabled)
                }
                Spacer()
            }
            .padding(.bottom, 20)
        }
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
                    ),
                    BudgetItem(
                        name: "Test Item 2",
                        maxValue: 100.00
                    ),
                    BudgetItem(
                        name: "Test Item 3",
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
                            ),
                            BudgetItem(
                                name: "Test Item 2",
                                maxValue: 100.00
                            ),
                            BudgetItem(
                                name: "Test Item 3",
                                maxValue: 100.00
                            )
                        ]
                    )
                ],
                oneOff: true
            )
        ) { }
    }
}
