//
//  PrivacyPolicySheet.swift
//  friendly-spork
//
//  Created by James on 19/2/2023.
//

import SwiftUI

struct PrivacyPolicySheet: View {
    @Environment(\.dismiss) var dismiss
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
        VStack {
            HStack {
                Spacer()
                
                Button {
                   dismiss()
                } label: {
                    Image(systemName: "chevron.down")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(Theme.Color.navy)
                        .padding()
                }
            }
            
            ScrollView {
                Text(.init(text))
                    .padding()
            }
        }
    }
}

struct PrivacyPolicySheet_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicySheet()
    }
}
