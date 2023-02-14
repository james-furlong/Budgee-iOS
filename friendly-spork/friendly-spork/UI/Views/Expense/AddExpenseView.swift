//
//  AddExpenseView.swift
//  friendly-spork
//
//  Created by James on 6/2/2023.
//

import SwiftUI

struct AddExpenseView: View {
    
    let completion: (BudgetItem) -> ()
    @State var name: String = ""
    @State var maximumAmount: Double?
    
    init(completion: @escaping (BudgetItem) -> ()) {
        self.completion = completion
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                VStack {
                    TextField("Name", text: $name)
                        .font(.system(size: 20))
                        .foregroundColor(Theme.Color.text)
                        .padding()
                }
                .background(Theme.Color.background)
                .cornerRadius(10)
                .padding([.leading, .trailing, .top], 20)
                
                VStack {
                    TextField("Amount", value: $maximumAmount, format: .number)
                        .font(.system(size: 20))
                        .foregroundColor(Theme.Color.text)
                        .keyboardType(.decimalPad)
                        .padding()
                }
                .background(Theme.Color.background)
                .cornerRadius(10)
                .padding([.leading, .trailing], 20)
                
                VStack {
                    Button {
                        if let max = maximumAmount {
                            let item = BudgetItem(
                                name: name,
                                maxValue: max
                            )
                            name = ""
                            maximumAmount = 0
                            completion(item)
                        }
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
                .padding([.bottom, .top], 20)
            }
        }
        .background(Theme.Color.backgroundSupp)
        .cornerRadius(20)
        .padding()
        
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView { _ in }
    }
}
