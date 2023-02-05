//
//  BudgetDashboardView.swift
//  friendly-spork
//
//  Created by James on 4/2/2023.
//

import SwiftUI

struct BudgetDashboardView: View {
    @State var name: String = "Test"
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            VStack {
                VStack(spacing: 0) {
                    HStack {
                        Text("Budgets")
                            .font(.system(size: 35))
                            .bold()
                            .foregroundColor(Color("Text"))
                            .padding(.leading, 20)
                        
                        Spacer()
                    }
                    
//                    List {
//                        ForEach(budgets, id: \.self) { budget in
//                            Text(budget.unwrappedName)
//                        }
//                    }
                }
                
                Spacer()
                
                VStack {
                    Button("Add") {
//                        let newItem = Item(context: moc)
//                        newItem.name = ""
//                        newItem.maximumAmount = 100.00
//                        newItem.iconName = ""
//
//                        try? moc.save()
                    }
                }
            }
        }
    }
}

struct BudgetDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetDashboardView()
    }
}
