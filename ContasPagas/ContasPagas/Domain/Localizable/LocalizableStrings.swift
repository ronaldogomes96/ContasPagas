//
//  LocalizableStrings.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 11/04/23.
//

import Foundation
import SwiftUI

enum LocalizableStrings: String {
    
    // MARK: - LOGIN
    
    case appName = "login-appName"
    case loginMessageTitle = "login-messageTitle"
    case loginButtonTitle = "login-button-title"
    
    // MARK: - DASHBOARD
    case tabbarBalance = "dashboard-tabbar-balance"
    case tabbarExpense = "dashboard-tabbar-expense"
    case tabbarEarnings = "dashboard-tabbar-earnings"
    case tabbarSettings = "dashboard-tabbar-settings"
    
    // MARK: - BALANCE
    case balanceYourBalance = "dashboard-balance-yourBalance"
    case balanceTotalExpense = "dashboard-balance-totalExpenses"
    case balanceTotalEarnings = "dashboard-balance-totalEarnings"
    
    // MARK: - TRADE
    
    case tradeAddTitle = "trade-title-add"
    case tradeEditTitle = "trade-title-edit"
    
    var localized: LocalizedStringKey {
        return LocalizedStringKey(self.rawValue)
    }
    
    var localizedString: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

