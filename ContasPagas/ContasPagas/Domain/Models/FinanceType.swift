//
//  FinanceType.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 17/04/23.
//

import Foundation

enum FinanceType: String {
    case expense
    case income
    
    var rawValue: String {
        switch self {
        case .expense:
            return LocalizableStrings.tabbarExpense.localizedString
        case .income:
            return LocalizableStrings.tabbarEarnings.localizedString
        }
    }
}
