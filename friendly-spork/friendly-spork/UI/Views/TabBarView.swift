//
//  TabBarView.swift
//  friendly-spork
//
//  Created by James on 17/2/2023.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var budget: Budget
    
    @State private var selectedTab: TabBarItem = .home
    @State var isShowingAddExpense: Bool = false
    
    let completion: () -> ()
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $selectedTab) {
                BudgetView(budget: budget)
                    .tag(TabBarItem.home)
                
                SpendHistoryView(budget: budget) {}
                    .tag(TabBarItem.spendHistory)
                
                AddSpendItemView(budget: budget) {}
                    .tag(TabBarItem.add)
                
                BudgetHistoryView(budget: budget)
                    .tag(TabBarItem.budgetHistory)
                
                SettingsView() { completion() }
                    .tag(TabBarItem.settings)
            }
            
            HStack(spacing: 0) {
                ForEach(TabBarItem.allCases, id: \.self) { item in
                    GeometryReader { geo in
                        Button {
                            if item == .add {
                                isShowingAddExpense = true
                            }
                            else {
                                selectedTab = item
                            }
                        } label: {
                            item.icon
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25.0, height: 25.0)
                                .foregroundColor(selectedTab == item ? Theme.Color.teal100 : Theme.Color.navy)
                                .padding(10)
                                .offset(x: -10, y: -5)
                        }
                    }
                    .frame(width: 25.0, height: 30.0)
                    .padding(.bottom, 5)
                    
                    if item != TabBarItem.allCases.last {
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical)
            .background(Theme.Color.backgroundSupp)
            .cornerRadius(30)
            .padding(.horizontal, 50)
            .padding(.vertical, 10)
            
            VStack {
                if isShowingAddExpense {
                    Color.black.opacity(0.6).ignoresSafeArea()
                        .transition(.opacity)
                        .onTapGesture {
                            isShowingAddExpense = false
                        }
                }
            }
            .animation(.default, value: isShowingAddExpense)
            
            VStack {
                if isShowingAddExpense {
                    AddSpendItemView(budget: budget) {
                        isShowingAddExpense = false
                    }
                    .transition(.move(edge: .bottom))
                }
            }
            .animation(.default, value: isShowingAddExpense)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView() { }.environmentObject(Theme.Constants.budget)
    }
}
