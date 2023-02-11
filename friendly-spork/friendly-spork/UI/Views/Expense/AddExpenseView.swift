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
            VStack(spacing: 0) {
                VStack {
                    TextField("Name", text: $name)
                        .padding()
                }
                .background()
                .cornerRadius(10)
                .padding(.bottom, 10)
                
                VStack {
                    TextField("Amount", value: $maximumAmount, format: .number)
                        
                        .keyboardType(.numberPad)
                        .padding()
                }
                .background()
                .cornerRadius(10)
                .padding(.bottom, 20)
                
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
            .padding()
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
