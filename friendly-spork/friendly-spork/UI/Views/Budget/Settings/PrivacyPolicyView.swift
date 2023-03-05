//
//  PrivacyPolicyView.swift
//  friendly-spork
//
//  Created by James on 19/2/2023.
//

import SwiftUI

struct PrivacyPolicyView: View {
    let completion: () -> ()
    
    private var text: String {
        if let filepath = Bundle.main.path(forResource: "privacyPolicy", ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                return contents
            } catch { }
        }
        
        return "File not found"
    }
    
    var body: some View {
        ZStack {
            Theme.Color.background.ignoresSafeArea()
            VStack {
                HStack {
                    Button {
                        completion()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(Theme.Color.navy)
                            .padding()
                    }
                    
                    Spacer()
                }
                
                ScrollView {
                    Text(.init(text))
                        .foregroundColor(Theme.Color.text)
                        .padding()
                }
            }
            
            VStack {
                Text("Privacy policy")
                    .font(.system(size: 25))
                    .foregroundColor(Theme.Color.text)
                    .padding(.top, 15)
                
                Spacer()
            }
        }
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView() {}
    }
}
