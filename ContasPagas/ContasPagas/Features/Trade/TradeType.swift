//
//  TradeType.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 17/04/23.
//

import Foundation

enum TradeType {
    case add
    case edit
    
    var titleName: String {
        switch self {
        case .add:
            return LocalizableStrings.tradeAddTitle.localizedString
        case .edit:
            return LocalizableStrings.tradeEditTitle.localizedString
        }
    }
}
