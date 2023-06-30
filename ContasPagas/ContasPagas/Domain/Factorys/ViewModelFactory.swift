//
//  ViewModelFactory.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 18/06/23.
//

import Foundation
import SwiftUI

protocol ViewModelFactoryProtocol {
    func makeTradeViewModel(tradeType: TradeType,
                            financeType: FinanceType,
                            financeName: String,
                            financeTypeName: String,
                            tradeValue: String,
                            selectedDate: Date,
                            isPaid: Bool) -> TradeViewModel
    func makeIncomesViewModel() -> IncomesViewModel
    func makeExpensesViewModel() -> ExpensesViewModel
    func makeBalanceViewModel() -> BalanceViewModel
    func makeSettingsViewModel() -> SettingsViewModel
}

@MainActor
class ViewModelFactory: ViewModelFactoryProtocol {
    
    private let respositoryManager = RepositoryManager.shared
    
    func makeTradeViewModel(tradeType: TradeType,
                            financeType: FinanceType,
                            financeName: String,
                            financeTypeName: String,
                            tradeValue: String,
                            selectedDate: Date,
                            isPaid: Bool) -> TradeViewModel {
        return TradeViewModel(tradeType: tradeType,
                              financeType: financeType,
                              financeName: financeName,
                              financeTypeName: financeTypeName,
                              tradeValue: tradeValue,
                              selectedDate: selectedDate,
                              isPaid: isPaid,
                              incomeUseCase: makeIncomeUseCase(),
                              expensesUseCase: makeExpenseUseCase())
    }
    
    func makeIncomesViewModel() -> IncomesViewModel {
        return IncomesViewModel(incomesUseCase: makeIncomeUseCase())
    }
    
    func makeExpensesViewModel() -> ExpensesViewModel {
        return ExpensesViewModel(expenseUseCase: makeExpenseUseCase(),
                                 expenseTypeUseCase: makeExpenseTypeUseCase())
    }
    
    func makeBalanceViewModel() -> BalanceViewModel {
        return BalanceViewModel(incomeUseCase: makeIncomeUseCase(),
                                expenseTypeUseCase: makeExpenseTypeUseCase(),
                                expensesUseCase: makeExpenseUseCase())
    }
    
    func makeSettingsViewModel() -> SettingsViewModel {
        return SettingsViewModel(authenticationFacade: AuthenticationFacade())
    }
    
    private func makeIncomeUseCase() -> FinancesUseCaseProtocol {
        return IncomeUseCase(repository: respositoryManager)
    }
    
    private func makeExpenseUseCase() -> FinancesUseCaseProtocol {
        return ExpenseUseCase(repository: respositoryManager)
    }
    
    private func makeExpenseTypeUseCase() -> FinancesUseCaseProtocol {
        return ExpensesTypeUseCase(repository: respositoryManager)
    }
}
