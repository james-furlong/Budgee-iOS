//
//  BackgroundView.swift
//  Budgee
//
//  Created by James on 12/3/2023.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack {
            Theme.Color.background.ignoresSafeArea()
            VStack {
                Image("home-background")
                    .resizable()
                    .ignoresSafeArea()
                    .frame(height: 250)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Theme.Color.teal100)
                
                Spacer()
            }
        }
        .opacity(0.7)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
