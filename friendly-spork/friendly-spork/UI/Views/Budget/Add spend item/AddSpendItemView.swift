//
//  AddSpendItemView.swift
//  friendly-spork
//
//  Created by James on 8/2/2023.
//

import SwiftUI

struct AddSpendItemView: View {
    @ObservedObject var budget: Budget
    @State private var name: String = ""
    @State private var amount: Double? = nil
    @State private var date: Date = Date()
    @State private var itemId: String = ""
    let completion: () -> ()
    
    private var buttonIsEnabled: Bool {
        return !name.isEmpty && amount != nil
    }
    
    private var buttonColor: Color {
        return buttonIsEnabled ? Theme.Color.teal100 : Theme.Color.teal20
    }
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack(spacing: 10) {
                    VStack {
                        HStack {
                            Text("Add spend item")
                                .font(.system(size: 35))
                                .bold()
                                .foregroundColor(Theme.Color.text)
                                .padding(.leading, 20)
                            
                            Spacer()
                            
                            Button {
                                completion()
                            } label: {
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 30))
                                    .foregroundColor(Theme.Color.text)
                            }
                            .padding()
                        }
                        .padding(.top, 20)
                        
                        VStack {
                            TextField("Name", text: $name)
                                .font(.system(size: 20))
                                .foregroundColor(Theme.Color.text)
                                .padding()
                        }
                        .background(Theme.Color.teal20)
                        .cornerRadius(10)
                        .padding([.leading, .trailing, .top], 20)
                        
                        VStack {
                            TextField("Amount", value: $amount, format: .number)
                                .font(.system(size: 20))
                                .foregroundColor(Theme.Color.text)
                                .keyboardType(.numberPad)
                                .padding()
                        }
                        .background(Theme.Color.teal20)
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
                                .accentColor(Theme.Color.teal100)
                            }
                            .padding(.trailing, 10)
                        }
                        .background(Theme.Color.teal20)
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
                                                .foregroundColor(Theme.Color.textHardSupp)
                                                .tag(item as BudgetItem)
                                            
                                            Spacer()
                                            
                                            Image(systemName: item.id == itemId ? "circle.fill" : "circle")
                                                .font(.system(size: 20))
                                                .foregroundColor(Theme.Color.teal100)
                                        }
                                    }
                                    .padding()
                                    .background(Theme.Color.navy)//.opacity(0.6))
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
                }
                .padding(.bottom, 35)
                .background()
                .cornerRadius(20, corners: [.topLeft, .topRight])
                .ignoresSafeArea()
            }
            .ignoresSafeArea()
        }
    }
}

struct AddSpendItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddSpendItemView(budget: Theme.Constants.budget)  { }
    }
}
