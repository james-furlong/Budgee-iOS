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
    @State var items: [BudgetItem] = [
        BudgetItem(name: "Fuel", maxValue: 200, items: []),
        BudgetItem(name: "Fuel", maxValue: 200, items: []),
        BudgetItem(name: "Fuel", maxValue: 200, items: [])
    ]
    @State var selectedInterval: Interval = .weekly
    @State var startDate: Date = Date()
    @State var oneOff: Bool = false
    
    // Transition states
    @State var addItemViewIsShowing: Bool = false
    @State var selectIntervalIsShowing: Bool = false
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
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 35))
                                    .foregroundColor(Theme.Color.text)
                                    .padding()
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
                        
                        Button {
                            selectIntervalIsShowing = true
                        } label: {
                            HStack {
                                Text("Select interval")
                                    .font(.system(size: 20))
                                    .foregroundColor(Theme.Color.text)
                                    .padding()
                                
                                Spacer()
                                
                                if let name = selectedInterval.name {
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
                            .accentColor(Theme.Color.teal100)
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
                                .toggleStyle(SwitchToggleStyle(tint: Theme.Color.teal100))
                        }
                        .background(Theme.Color.background)
                        .cornerRadius(10)
                        .padding([.leading, .trailing, .bottom], 20)
                    }
                    .background(Theme.Color.backgroundSupp)
                    .cornerRadius(10)
                    .padding([.leading, .trailing])
                    
                    if items.isEmpty {
                        VStack(spacing: 0) {
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
                                .background(Theme.Color.teal100)
                                .cornerRadius(30)
                                .padding(.bottom, 20)
                                
                                Spacer()
                            }
                        }
                        .padding(.top, 30)
                    }
                    else {
                        HStack {
                            Text("Categories")
                            
                            Spacer()
                            
                            Button {
                                addItemViewIsShowing = true
                            } label: {
                                Image(systemName: "plus")
                                    .font(.system(size: 30))
                                    .foregroundColor(Theme.Color.teal100)
                            }
                            .padding(.trailing, 50)
                        }
                        .padding([.leading, .top], 30)
                        .padding(.bottom, -15)
                        
                        VStack(spacing: items.isEmpty ? 0 : 30) {
                                ScrollView {
                                    ForEach(items, id: \.self) { item in
                                        ExpenseView(name: item.name, maximumAmount: item.maximumValue)
                                    }
                                }
                                .padding([.top, .bottom])
                        }
                        .background(Theme.Color.backgroundSupp)
                        .cornerRadius(10)
                        .padding()
                    }
                }
                
                Spacer()
                
                VStack {
                    Button {
                        let initialInterval: BudgetInterval = BudgetInterval(
                            startDateTime: startDate,
                            endDateTime: selectedInterval.endDate(from: startDate) ,
                            items: items
                        )
                        
                        let budget = Budget(
                            id: UUID().uuidString,
                            name: name,
                            intervalType: selectedInterval,
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
                            .background(buttonIsEnabled ? Theme.Color.teal100 : Theme.Color.teal20)
                            .clipShape(Capsule())
                    }
                    .disabled(!buttonIsEnabled)
                    .padding(.bottom, 50)
                }
            }
            .ignoresSafeArea(.keyboard)
            .background(Theme.Color.background)
            .cornerRadius(15, corners: [.topRight, .topLeft])
            
            ZStack {
                if addItemViewIsShowing {
                    Color(.black).opacity(0.4).ignoresSafeArea()
                        .onTapGesture {
                            addItemViewIsShowing = false
                        }
                    
                    AddExpenseView { newItem in
                        items.append(newItem)
                        addItemViewIsShowing = false
                    }
                    .transition(.opacity)
                }
            }
            .animation(.default, value: addItemViewIsShowing)
            
            VStack {
                if selectIntervalIsShowing {
                    Spacer()
                    
                    ZStack {
                        Color(.black).opacity(0.4).ignoresSafeArea()
                            .onTapGesture {
                                selectIntervalIsShowing = false
                            }
                        
                        HStack {
                            VStack(spacing: 0) {
                                ForEach(Interval.allCases, id: \.self) { interval in
                                    Button {
                                        selectedInterval = interval
                                        selectIntervalIsShowing = false
                                    } label: {
                                        HStack {
                                            Spacer()
                                            Text(interval.name)
                                                .font(.system(size: 25))
                                                .foregroundColor(Theme.Color.text)
                                                .padding([.top, .bottom])
                                            Spacer()
                                        }
                                    }
                                    .background(Theme.Color.teal100)
                                    .cornerRadius(15)
                                    .padding(5)
                                }
                            }
                            .padding()
                        }
                        .background(Theme.Color.backgroundSupp)
                        .cornerRadius(15)
                        .padding()
                    }
                    .transition(.opacity)
                }
            }
            .animation(.default, value: selectIntervalIsShowing)
            
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
