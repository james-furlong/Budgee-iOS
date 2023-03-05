//
//  SettingsView.swift
//  friendly-spork
//
//  Created by James on 19/2/2023.
//

import SwiftUI

struct SettingsView: View {
    @State var showingPrivacyPolicy: Bool = false
    let completion: () -> ()
    
    var body: some View {
        ZStack {
            Theme.Color.background.ignoresSafeArea()
            Theme.Color.background.ignoresSafeArea()
            VStack {
                Image("home-background")
                    .resizable()
                    .ignoresSafeArea()
                    .frame(height: 250)
                
                Spacer()
            }
            
            VStack(spacing: 10) {
                HStack {
                    Text("Settings")
                        .font(.system(size: 40, weight: .heavy))
                        .foregroundColor(Theme.Color.textHard)
                        .padding(.leading, 20)
                    
                    Spacer()
                }
                .padding(.top, 20)
                
                VStack {
                    ScrollView {
                        VStack {
                            ForEach(SettingsItem.allCases, id: \.self) { item in
                                VStack {
                                    Button {
                                        if item == .privacyPolicy {
                                            showingPrivacyPolicy = true
                                        }
                                        else {
                                            completion()
                                        }
                                    } label: {
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text(item.title)
                                                    .font(.system(size: 25))
                                                    .foregroundColor(Theme.Color.text)
                                            }
                                            
                                            Spacer()
                                            
                                            Image(systemName: "chevron.right")
                                                .font(.system(size: 20))
                                                .foregroundColor(Theme.Color.text)
                                        }
                                        .padding()
                                        .background(Theme.Color.teal.opacity(0.4))
                                        .cornerRadius(10)
                                    }
                                    .padding([.leading, .trailing])
                                }
                            }
                        }
                        .cornerRadius(10)
                        .padding()
                        .padding(.top, 20)
                        
                        Text("V 1.0.0")
                            .font(.system(.footnote))
                            .padding(.bottom, 60)
                    }
                    .background(Theme.Color.background)
                    .cornerRadius(15, corners: [.topLeft, .topRight])
                }
            }
            
            VStack {
                if showingPrivacyPolicy {
                    PrivacyPolicyView {
                        showingPrivacyPolicy = false
                    }
                    .transition(.move(edge: .trailing))
                }
            }
            .animation(.default, value: showingPrivacyPolicy)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView() { }
    }
}
