//
//  ExpenseView.swift
//  friendly-spork
//
//  Created by James on 6/2/2023.
//

import SwiftUI

struct ExpenseView: View {
    let name: String
    let maximumAmount: Double
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    Text(name)
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                    
                    Spacer()
                    
                    Text("$\(String(format: "%.2f", maximumAmount))")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .padding()
                }
                .cornerRadius(10)
            }
            .padding([.leading, .trailing], 10)
        }
        .background(Theme.Color.teal70)
        .cornerRadius(20)
        .padding([.leading, .trailing])
    }
}

struct ExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseView(name: "Test", maximumAmount: 100.00)
    }
}
