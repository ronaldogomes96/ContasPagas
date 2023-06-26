//
//  ViewFactory.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 18/06/23.
//

import Foundation
import SwiftUI

class ViewFactory {
    
    private let viewModelFactory: ViewModelFactoryProtocol
    
    init(viewModelFactory: ViewModelFactoryProtocol) {
        self.viewModelFactory = viewModelFactory
    }
    
    @ViewBuilder func makeLoginView() -> some View {
        LoginView(viewModel: AuthenticationViewModel())
    }
    
    @ViewBuilder func makeDashboardView() -> some View {
        DashboardTabBarView(viewFactory: self)
    }
    
    @ViewBuilder func makeBalanceView() -> some View {
        BalanceView(viewModel: self.viewModelFactory.makeBalanceViewModel())
    }
    
    @ViewBuilder func makeIncomesView() -> some View {
        IncomesView(viewModel: self.viewModelFactory.makeIncomesViewModel(), viewFactory: self)
    }
    
    @ViewBuilder func makeExpenseView() -> some View {
        ExpensesView(viewModel: self.viewModelFactory.makeExpensesViewModel(), viewFactory: self)
    }
    
    @ViewBuilder func makeSettingsView() -> some View {
        SettingsView(viewModel: AuthenticationViewModel(), viewFactory: self)
    }
    
    @ViewBuilder func makeTradeView(tradeType: TradeType,
                                    financeType: FinanceType,
                                    financeName: String,
                                    financeTypeName: String,
                                    tradeValue: String,
                                    selectedDate: Date,
                                    isPaid: Bool) -> some View {
        TradeView(viewModel: self.viewModelFactory.makeTradeViewModel(tradeType: tradeType,
                                                                      financeType: financeType,
                                                                      financeName: financeName,
                                                                      financeTypeName: financeTypeName,
                                                                      tradeValue: tradeValue,
                                                                      selectedDate: selectedDate,
                                                                      isPaid: isPaid))
    }
}
