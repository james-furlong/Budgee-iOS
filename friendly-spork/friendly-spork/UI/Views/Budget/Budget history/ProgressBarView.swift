//
//  ProgressBarView.swift
//  friendly-spork
//
//  Created by James on 21/2/2023.
//

import SwiftUI

struct ProgressBarView: View {
    let totalAmount: Double
    let maxAmount: Double
    
    var backgroundColor: Color {
        if totalAmount >= maxAmount {
            return Theme.Color.red
        }
        
        if totalAmount >= (maxAmount * 0.90) {
            return Theme.Color.orange
        }
        
        return Theme.Color.teal
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack {
                    Rectangle()
                        .frame(height: 30)
                        .foregroundColor(backgroundColor.opacity(0.4))
                    
                    Rectangle()
                        .frame(height: 30)
                        .foregroundColor(backgroundColor)
                        .padding(.trailing, widthPadding(geo.size.width))
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .frame(height: 30)
    }
    
    private func widthPadding(_ geoWidth: Double) -> Double {
        let percent = totalAmount / maxAmount
        let amount = geoWidth * percent
        return geoWidth - amount
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(totalAmount: 100.0, maxAmount: 200.0)
    }
}
