//
//  SettingsView.swift
//  friendly-spork
//
//  Created by James on 19/2/2023.
//

import SwiftUI

struct SettingsView: View {
    @State var showingSheet: Bool = false
    let completion: () -> ()
    
    var body: some View {
        ZStack {
            Theme.Color.background.ignoresSafeArea()
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Settings")
                            .font(.system(size: 35))
                            .bold()
                            .foregroundColor(Theme.Color.text)
                            .padding(.leading, 20)
                    }
                    
                    Spacer()
                }
                .padding(.top, 20)
                
                ScrollView {
                    VStack {
                        VStack {
                            ForEach(SettingsItem.allCases, id: \.self) { item in
                                VStack {
                                    Button {
                                        if item == .privacyPolicy {
                                            showingSheet.toggle()
                                        }
                                        else {
                                            completion()
                                        }
                                    } label: {
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text(item.title)
                                                    .font(.system(size: 25))
                                                    .foregroundColor(Theme.Color.textHardSupp)
                                            }
                                            
                                            Spacer()
                                            
                                            Image(systemName: "chevron.right")
                                                .font(.system(size: 20, weight: .bold))
                                                .foregroundColor(Theme.Color.textHardSupp)
                                        }
                                        .padding()
                                        .background(Theme.Color.navy)
                                        .cornerRadius(10)
                                    }
                                    .sheet(isPresented: $showingSheet) {
                                        if item == .privacyPolicy {
                                            PrivacyPolicySheet()
                                        }
                                    }
                                    .padding([.leading, .trailing])
                                }
                            }
                        }
                        .padding([.top, .bottom])
                    }
                    .background(Theme.Color.backgroundSupp)
                    .cornerRadius(10)
                    .padding()
                }
                
                Text("V 1.0.0")
                    .font(.system(.footnote))
                    .padding(.bottom, 60)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView() { }
    }
}
