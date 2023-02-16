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
    @State var items: [BudgetItem] = []
    @State var interval: Interval = .weekly
    @State var startDate: Date = Date()
    @State var oneOff: Bool = false
    
    @State var addItemViewIsShowing: Bool = false
    @State var errorIsShowing: Bool = false
    
    private var buttonIsEnabled: Bool {
        return !name.isEmpty && !items.isEmpty
    }
    
    private var buttonOpacity: Double {
        return buttonIsEnabled ? 1.0 : 0.3
    }
    
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
                                    .foregroundColor(Theme.Color.red)
                            }
                            .padding()
                        }
                    }
                     
                    HStack {
                        Text("Details")
                        
                        Spacer()
                    }
                    .padding(.leading, 30)
                    .padding(.bottom, -5)
                    
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
                                
                                if let name = interval.name {
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
                        
                        HStack {
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
                            .padding(.trailing, 10)
                        }
                        .background(Theme.Color.background)
                        .cornerRadius(10)
                        .padding([.leading, .trailing], 20)
                        
                        HStack {
                            Text("One-off")
                                .font(.system(size: 20))
                                .foregroundColor(Theme.Color.text)
                                .padding()
                            
                            Spacer()
                            
                            Toggle("", isOn: $oneOff)
                                .padding(.trailing, 20)
                                .toggleStyle(SwitchToggleStyle(tint: Theme.Color.green))
                        }
                        .background(Theme.Color.background)
                        .cornerRadius(10)
                        .padding([.leading, .trailing, .bottom], 20)
                    }
                    .background(Theme.Color.backgroundSupp)
                    .cornerRadius(10)
                    .padding([.leading, .trailing])
                    
                    HStack {
                        Text("Categories")
                        
                        Spacer()
                    }
                    .padding([.leading, .top], 30)
                    .padding(.bottom, -15)
                    
                    VStack(spacing: items.isEmpty ? 0 : 30) {
                        VStack {
                            ForEach(items, id: \.self) { item in
                                ExpenseView(name: item.name, maximumAmount: item.maximumValue)
                            }
                        }
                        .padding(.top)
                        
                        HStack {
                            Spacer()
                            
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
                            
                            Spacer()
                        }
                    }
                    .background(Theme.Color.backgroundSupp)
                    .cornerRadius(10)
                    .padding()
                }
                
                Spacer()
                
                VStack {
                    Button {
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
                            intervals: [initialInterval],
                            oneOff: oneOff
                        )
                        
                        do {
                            try Injector.fileManager.saveOrUpdateBudget(budget: budget)
                            completion()
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
                            .foregroundColor(Theme.Color.textHard.opacity(buttonOpacity))
                            .padding([.leading, .trailing], 40)
                            .padding([.top, .bottom])
                            .background(Theme.Color.green.opacity(buttonOpacity))
                            .clipShape(Capsule())
                    }
                    .disabled(!buttonIsEnabled)
                    
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
