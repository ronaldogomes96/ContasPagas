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
    
    // MARK: - FINANCE DETAILS
    case financeDetailsSituationLabel = "financeDetails-paid-situation"
    case financeDetailsNotPaid = "financeDetails-paid-notPaid"
    
    // MARK: - TRADE
    
    case tradeAddTitle = "trade-title-add"
    case tradeEditTitle = "trade-title-edit"
    case tradeFinanceType = "trade-textfield-type"
    case tradeFinanceName = "trade-textfield-financeType"
    case tradeFinanceValue = "trade-textfield-value"
    case tradeFinanceDate = "trade-datapicker-date"
    case tradeToglePayed = "trade-togle-payed"
    case tradeAlertTitle = "trade-alert-title"
    case tradeAlertMessage = "trade-alert-message"
    case tradeDismissButton = "trade-dismissButton"
    case tradeSavenButton = "trade-save-button"
    
    var localized: LocalizedStringKey {
        return LocalizedStringKey(self.rawValue)
    }
    
    var localizedString: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

