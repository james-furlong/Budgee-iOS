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
    @State var items: [BudgetItem] = [BudgetItem(name: "Test", maxValue: 100), BudgetItem(name: "Test", maxValue: 100)]
    @State var interval: Interval?
    @State var startDate: Date = Date()
    
    @State var addItemViewIsShowing: Bool = false
    @State var errorIsShowing: Bool = false
    
    let completion: () -> ()
    
    var body: some View {
        ZStack {
            Theme.Color.background.ignoresSafeArea()
            VStack {
                VStack {
                    VStack {
                        HStack {
                            Text("Create budget")
                                .font(.system(size: 35))
                                .bold()
                                .foregroundColor(Theme.Color.text)
                                .padding(.leading, 20)
                            
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
                    }
                     
                    VStack(spacing: 15) {
                        VStack {
                            TextField("Name", text: $name)
                                .font(.system(size: 20))
                                .foregroundColor(Theme.Color.text)
                                .padding()
                        }
                        .background(Theme.Color.background)
                        .cornerRadius(10)
                        .padding([.leading, .trailing, .top], 20)
                        
                        Menu {
                            Picker(selection: $interval) {
                                ForEach(intervals, id: \.self) { interval in
                                    Text(interval.name)
                                        .font(.system(size: 40))
                                        .foregroundColor(Theme.Color.text)
                                }
                            } label: { }
                        } label: {
                            HStack {
                                Text("Select interval")
                                    .font(.system(size: 20))
                                    .foregroundColor(Theme.Color.text)
                                    .padding()
                                
                                Spacer()
                                
                                if let name = interval?.name {
                                    Text(name)
                                        .font(.system(size: 20))
                                        .foregroundColor(Theme.Color.text)
                                        .padding()
                                }
                                else {
                                    Image(systemName: "chevron.down")
                                        .font(.system(size: 20))
                                        .foregroundColor(Theme.Color.text)
                                        .padding()
                                }
                            }
                        }
                        .background(Theme.Color.background)
                        .cornerRadius(10)
                        .padding([.leading, .trailing], 20)
                        
                        DatePicker(selection: $startDate, in: Date.now..., displayedComponents: .date) {
                            HStack {
                                Text("Start date")
                                    .font(.system(size: 20))
                                    .foregroundColor(Theme.Color.text)
                                    .padding()
                            }
                        }
                        .datePickerStyle(.compact)
                        .accentColor(Theme.Color.green)
                        .background(Theme.Color.background)
                        .cornerRadius(10)
                        .padding([.leading, .trailing, .bottom], 20)
                    }
                    .background(Theme.Color.backgroundSupp)
                    .cornerRadius(10)
                    .padding([.leading, .trailing])
                    
                    VStack(spacing: 30) {
                        VStack {
                            ForEach(items, id: \.self) { item in
                                ExpenseView(name: item.name, maximumAmount: item.maximumValue)
                            }
                        }
                        .padding(.top, 20)
                        
                        
                        Button {
                            addItemViewIsShowing = true
                        } label: {
                            Text("Add expense category")
                                .frame(height: 25)
                                .padding([.leading, .trailing], 40)
                                .font(.system(size: 20))
                                .bold()
                                .foregroundColor(Theme.Color.textHard)
                        }
                        .padding()
                        .background(Theme.Color.green)
                        .cornerRadius(30)
                        .padding(.bottom, 20)
                    }
                    .background(Theme.Color.backgroundSupp)
                    .cornerRadius(10)
                    .padding()
                }
                
                Spacer()
                
                VStack {
                    Button {
                        if let interval {
                            let initialInterval: BudgetInterval = BudgetInterval(
                                startDateTime: startDate,
                                endDateTime: interval.endDate(from: startDate) ,
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
                        }
                    } label: {
                        Text("Create")
                            .font(.system(size: 20))
                            .bold()
                            .foregroundColor(Theme.Color.textHard)
                    }
                    .padding([.leading, .trailing], 40)
                    .padding([.top, .bottom])
                    .background(Theme.Color.green)
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
                        .foregroundColor(Theme.Color.text)
                        .padding()
                        .background(Theme.Color.red)
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
