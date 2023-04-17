//
//  DashboardTabBarView.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 12/04/23.
//

import SwiftUI

struct DashboardTabBarView: View {
    var body: some View {
        TabView {
            BalanceView()
                .tabItem {
                    Image(systemName: "dollarsign.circle.fill")
                    Text(LocalizableStrings.tabbarBalance.localized)
                }
            IncomesView()
                .tabItem {
                    Image(systemName: "plus.circle")
                    Text(LocalizableStrings.tabbarEarnings.localized)
                }
            ExpensesView()
                .tabItem {
                    Image(systemName: "minus.circle")
                    Text(LocalizableStrings.tabbarExpense.localized)
                }
            Text(LocalizableStrings.tabbarSettings.localized)
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
        DashboardTabBarView()
    }
}
