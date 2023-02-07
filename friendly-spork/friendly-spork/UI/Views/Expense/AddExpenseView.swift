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
    @State var maximumAmount: Double = 0
    
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
                    let item = BudgetItem(
                        name: name,
                        maximumValue: maximumAmount,
                        currentValue: 0
                    )
                    name = ""
                    maximumAmount = 0
                    completion(item)
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
            .padding()
        }
        .background(Color("BackgroundSupp"))
        .cornerRadius(20)
        .padding()
        
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView { _ in }
    }
}