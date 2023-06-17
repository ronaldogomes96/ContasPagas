//
//  BalanceViewModel.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 04/06/23.
//

import Foundation

@MainActor
class BalanceViewModel: ObservableObject {
    
    private let incomeUseCase: any FinancesUseCaseProtocol
    private let expenseTypeUseCase: any FinancesUseCaseProtocol
    private let expensesUseCase: any FinancesUseCaseProtocol
    
    @Published var totalBalance: Double = 0
    @Published var totalExpenses: Double = 0
    @Published var totalIncomes: Double = 0
    @Published var hasError: Bool = false
    
    init(incomeUseCase: any FinancesUseCaseProtocol,
         expenseTypeUseCase: any FinancesUseCaseProtocol,
         expensesUseCase: any FinancesUseCaseProtocol) {
        self.incomeUseCase = incomeUseCase
        self.expenseTypeUseCase = expenseTypeUseCase
        self.expensesUseCase = expensesUseCase
    }
    
    func getUserInformations() async {
        do {
            totalExpenses = try await totalExpenses()
            totalIncomes = try await totalIncomes()
            totalBalance = totalIncomes - totalExpenses
            hasError = false
        } catch {
            hasError = true
        }
    }
    
    private func totalExpenses() async throws -> Double {
        guard let expensesType = try await expenseTypeUseCase.readAll() as? [ExpenseType],
              let expenses = try await expensesUseCase.readAll() as? [ExpenseDetailsModel] else {
            return 0
        }
        
        var expensesTypeValue: Double = 0
        
        expensesType.forEach { expenseType in
            expensesTypeValue += expenseType.expenses.reduce(into: expensesTypeValue) { result, expense in
                result += expense.value
            }
        }
        
        let expensesValue = expenses.reduce(into: 0.0) { result, expense in
            result += expense.value
        }
        
        return expensesTypeValue + expensesValue
    }
    
    private func totalIncomes() async throws -> Double {
        guard let incomes = try await incomeUseCase.readAll() as? [IncomeDetailsModel] else {
            return 0
        }
        
        return incomes.reduce(into: 0.0) { result, expense in
            result += expense.value
        }
    }
}
