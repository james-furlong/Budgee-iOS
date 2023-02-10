//
//  AddBudgetView.swift
//  friendly-spork
//
//  Created by James on 4/2/2023.
//

import SwiftUI

struct AddBudgetView: View {
    let intervals: [Interval] = [.weekly, .fortnightly, .monthly]
    @State var name: String = ""
    @State var items: [BudgetItem] = [BudgetItem(name: "Test", maxValue: 100)]
    @State var interval: Interval = .weekly
    @State var startDate: Date = .now
    
    @State var addItemViewIsShowing: Bool = false
    @State var errorIsShowing: Bool = false
    
    let completion: () -> ()
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            VStack {
                VStack(spacing: 10) {
                    VStack {
                        HStack {
                            Text("Create budget")
                                .font(.system(size: 35))
                                .bold()
                                .foregroundColor(Color("Text"))
                                .padding(.leading, 20)
                            
                            Spacer()
                            
                            Button {
                                completion()
                            } label: {
                                Image(systemName: "multiply")
                                    .font(.system(size: 35))
                                    .foregroundColor(Color("Green"))
                            }
                            .padding()
                        }
                        
                        TextField("Name", text: $name)
                            .font(.system(size: 25))
                            .underlineTextField()
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                        
                        Menu {
                            Picker(selection: $interval) {
                                ForEach(intervals, id: \.self) { interval in
                                    Text(interval.name)
                                        .font(.system(size: 40))
                                        .foregroundColor(Color("Text"))
                                }
                            } label: { }
                        } label: {
                            HStack {
                                Text("Select interval  -->")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color("Text"))
                                    .padding()
                                
                                Spacer()
                                
                                Text(interval.name)
                                    .font(.system(size: 20))
                                    .foregroundColor(Color("Text"))
                                    .padding()
                            }
                        }
                        .background(Color("Navy").opacity(0.2))
                        .cornerRadius(20)
                        .padding([.leading, .trailing], 30)
                        
                        DatePicker(selection: $startDate, in: Date.now..., displayedComponents: .date) {
                            HStack {
                                Text("Start date  -->")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color("Text"))
                                    .padding()
                                
                            }
                        }
                        .background(Color("Navy").opacity(0.2))
                        .cornerRadius(20)
                        .padding([.leading, .trailing], 30)
                    }
                    .padding(.bottom, 50)
                    
                    VStack {
                        ForEach(items, id: \.self) { item in
                            ExpenseView(name: item.name, maximumAmount: item.maximumValue)
                        }
                    }
                    .padding(.bottom, 30)

                    
                    Button {
                        addItemViewIsShowing = true
                    } label: {
                        Text("Add expense category")
                            .font(.system(size: 20))
                            .bold()
                            .foregroundColor(Color("TextSupp"))
                    }
                    .padding([.leading, .trailing], 40)
                    .padding()
                    .background(Color("Green"))
                    .clipShape(Capsule())
                }
                
                Spacer()
                
                VStack {
                    Button {
                        let initialInterval: BudgetInterval = BudgetInterval(
                            startDateTime: startDate,
                            endDateTime: interval.endDate(from: startDate),
                            items: items
                        )
                        
                        let budget = Budget(
                            id: UUID().uuidString,
                            name: name,
                            intervalType: interval,
                            defaultItems: items,
                            intervals: [initialInterval]
                        )
                        
                        do {
                            try Injector.fileManager.saveOrUpdateBudget(budget: budget)
                        }
                        catch {
                            Injector.log.error("Unable to save budget")
                            errorIsShowing = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                errorIsShowing = false
                            }
                        }
                    } label: {
                        Text("Create")
                            .font(.system(size: 20))
                            .bold()
                            .foregroundColor(Color("TextSupp"))
                    }
                    .padding([.leading, .trailing], 40)
                    .padding([.top, .bottom])
                    .background(Color("Green"))
                    .clipShape(Capsule())
                }
            }
            .ignoresSafeArea(.keyboard)
            
            if addItemViewIsShowing {
                Color(.black).opacity(0.4).ignoresSafeArea()
                AddExpenseView { newItem in
                    items.append(newItem)
                    addItemViewIsShowing = false
                }
                .transition(.opacity)
            }
            
            if errorIsShowing {
                VStack {
                    Spacer()
                    
                    Text("Couldn't create budget")
                        .font(.system(size: 18))
                        .foregroundColor(Color("TextSupp"))
                        .padding()
                        .background(Color("Red"))
                        .cornerRadius(20)
                        .transition(.opacity)
                }
            }
        }
    }
}

struct AddBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        AddBudgetView { }
    }
}
