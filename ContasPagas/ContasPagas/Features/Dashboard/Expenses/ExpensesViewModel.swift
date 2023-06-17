//
//  ExpensesViewModel.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 14/04/23.
//

import Foundation

@MainActor
class ExpensesViewModel: ObservableObject {
    @Published var expensesDetails = [ExpenseDetailsModel]()
    @Published var expensesType = [ExpenseType]()
    @Published var hasError: Bool = false
    
    private var expenseUseCase: any FinancesUseCaseProtocol
    private var expenseTypeUseCase: any FinancesUseCaseProtocol
    
    init(expenseUseCase: any FinancesUseCaseProtocol,
         expenseTypeUseCase: any FinancesUseCaseProtocol) {
        self.expenseUseCase = expenseUseCase
        self.expenseTypeUseCase = expenseTypeUseCase
    }
    
    func fecthExpenses() async {
        do {
            guard let expenses = try await expenseUseCase.readAll() as? [ExpenseDetailsModel],
                  let expensesType = try await expenseTypeUseCase.readAll() as? [ExpenseType] else {
                hasError = true
                return
            }
            
            self.expensesDetails = expenses
            self.expensesType = expensesType
            hasError = false
        } catch {
            hasError = true
        }
    }
    
    func getTotalExpensesValue() -> Double {
        var value: Double = 0.0
        
        expensesDetails.forEach {
            if !$0.paid {
                value += $0.value
            }
        }
        
        expensesType.forEach {
            $0.expenses.forEach {
                if !$0.paid {
                    value += $0.value
                }
            }
        }
        
        return value
    }
}
