//
//  DashboardTabBarView.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 12/04/23.
//

import SwiftUI

struct DashboardTabBarView: View {
    private let viewFactory: ViewFactory
    
    init(viewFactory: ViewFactory) {
        self.viewFactory = viewFactory
    }
    
    var body: some View {
        TabView {
            viewFactory.makeBalanceView()
                .tabItem {
                    Image(systemName: "dollarsign.circle.fill")
                    Text(LocalizableStrings.tabbarBalance.localized)
                }
            viewFactory.makeIncomesView()
                .tabItem {
                    Image(systemName: "plus.circle")
                    Text(LocalizableStrings.tabbarEarnings.localized)
                }
            viewFactory.makeExpenseView()
                .tabItem {
                    Image(systemName: "minus.circle")
                    Text(LocalizableStrings.tabbarExpense.localized)
                }
            viewFactory.makeSettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text(LocalizableStrings.tabbarSettings.localized)
                }
        }
        .toolbar(.visible, for: .tabBar)
        .toolbarBackground(Color.white, for: .tabBar)
        .navigationBarBackButtonHidden()
    }
}

struct DashboardTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardTabBarView(viewFactory: ViewFactory(viewModelFactory: ViewModelFactory()))
    }
}
