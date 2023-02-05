//
//  BudgetView.swift
//  friendly-spork
//
//  Created by James on 4/2/2023.
//

import SwiftUI

struct BudgetView: View {
    @State var name: String = "Test"
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            VStack {
                VStack(spacing: 0) {
                    HStack {
                        Text("Hey \(name)!")
                            .font(.system(size: 35))
                            .bold()
                            .foregroundColor(Color("Text"))
                            .padding(.leading, 20)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text("You are currently under your budget")
                            .font(.system(size: 20))
                            .foregroundColor(Color("Text"))
                            .multilineTextAlignment(.leading)
                            .padding(.leading, 20)
                        
                        Spacer()
                    }
                }
                
                Spacer()
                
                VStack {
                    Button("Add") {
                        print("Add new spend item")
                    }
                }
            }
        }
    }
}

struct BudgetView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetView()
    }
}
