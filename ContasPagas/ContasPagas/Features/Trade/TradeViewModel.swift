//
//  TradeViewModel.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 17/04/23.
//

import SwiftUI

class TradeViewModel: ObservableObject {
    
    var tradeType: TradeType
    var financeType: FinanceType
    @State var financeName = ""
    @State var financeTypeName = ""
    @State var tradeValue = ""
    @State var selectedDate = Date()
    
    init(tradeType: TradeType,
         financeType: FinanceType,
         financeName: String = "",
         financeTypeName: String = "",
         tradeValue: String = "",
         selectedDate: Date = Date()) {
        self.tradeType = tradeType
        self.financeType = financeType
        self.financeName = financeName
        self.financeTypeName = financeTypeName
        self.tradeValue = tradeValue
        self.selectedDate = selectedDate
    }
    
    func saveTradeWithSuccess() -> Bool {
        return false
    }
}
