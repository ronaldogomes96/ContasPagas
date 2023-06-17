//
//  TradeViewModel.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 17/04/23.
//

import SwiftUI

@MainActor
class TradeViewModel: ObservableObject {
    
    var tradeType: TradeType
    var financeType: FinanceType
    @Published var financeName = ""
    @Published var financeTypeName = ""
    @Published var tradeValue = ""
    @Published var selectedDate = Date()
    @Published var isPaid = false
    private let incomeUseCase: any FinancesUseCaseProtocol
    private let expensesUseCase: any FinancesUseCaseProtocol
    
    init(tradeType: TradeType,
         financeType: FinanceType,
         financeName: String = "",
         financeTypeName: String = "",
         tradeValue: String = "",
         selectedDate: Date = Date(),
         isPaid: Bool = false,
         incomeUseCase: any FinancesUseCaseProtocol,
         expensesUseCase: any FinancesUseCaseProtocol) {
        self.tradeType = tradeType
        self.financeType = financeType
        self.financeName = financeName
        self.financeTypeName = tradeType.titleName
        self.tradeValue = tradeValue
        self.selectedDate = selectedDate
        self.isPaid = isPaid
        self.incomeUseCase = incomeUseCase
        self.expensesUseCase = expensesUseCase
    }
    
    func saveTradeWithSuccess() async -> Bool {
        if tradeType == .add {
            if financeType == .expense {
                do {
                    try await expensesUseCase.add(finance: ExpenseDetailsModel(name: financeName,
                                                                               value: Double(tradeValue) ?? 0,
                                                                               date: selectedDate,
                                                                               paid: isPaid))
                    
                    return true
                } catch {
                    return false
                }
            } else {
                do {
                    try await incomeUseCase.add(finance: IncomeDetailsModel(name: financeName,
                                                                            value: Double(tradeValue) ?? 0,
                                                                            date: selectedDate))
                    return true
                } catch {
                    return false
                }
            }
        } else {
            if financeType == .expense {
                do {
                    try await expensesUseCase.update(finance: ExpenseDetailsModel(name: financeName,
                                                                               value: Double(tradeValue) ?? 0,
                                                                               date: selectedDate,
                                                                               paid: isPaid))
                    
                    return true
                } catch {
                    return false
                }
            } else {
                do {
                    try await incomeUseCase.update(finance: IncomeDetailsModel(name: financeName,
                                                                            value: Double(tradeValue) ?? 0,
                                                                            date: selectedDate))
                    return true
                } catch {
                    return false
                }
            }
        }
    }
}
