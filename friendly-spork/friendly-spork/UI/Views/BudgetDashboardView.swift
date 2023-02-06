//
//  BudgetDashboardView.swift
//  friendly-spork
//
//  Created by James on 4/2/2023.
//

import SwiftUI

struct BudgetDashboardView: View {
    @State var budgets = Injector.fileManager.retrieveBudgets()
    @State var name: String = "Test"
    @State var addBudgetShowing: Bool = false
    
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
                        
                        Button {
                            print("Add budget")
                        } label: {
                            Image(systemName: "plus.circle")
                                .font(.system(size: 35))
                                .foregroundColor(Color("Green"))
                        }
                        .padding()
                    }
                    
                    List {
                        ForEach(budgets, id: \.self) { budget in
                            Text(budget.name)
                        }
                    }
                }
            }
            
            if budgets.isEmpty {
                Button {
                    print("Add initial budget")
                } label: {
                    Text("Add initital budget")
                        .font(.system(size: 25))
                        .foregroundColor(Color("TextSupp"))
                        .padding([.leading, .trailing], 30)
                        .padding()
                        .background(Color("Green"))
                        .cornerRadius(20)
                }
            }
            
            if addBudgetShowing {
                AddBudgetView {
                    print("Add")
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
