//
//  ExpensesViewModel.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 14/04/23.
//

import Foundation

class ExpensesViewModel: ObservableObject {
    @Published var expensesDetails = [ExpenseDetailsModel]()
    @Published var expensesType = [ExpenseType]()
    
    func fecthExpenses() {
        // atualizar expensesModel
        let expenseDetail = ExpenseDetailsModel(name: "Uber",
                                                value: 17.35,
                                                date: Date(),
                                                paid: true)
        let expenseModel = ExpensesModel(expenses: [expenseDetail,
                                                           ExpenseDetailsModel(name: "Uber",
                                                                               value: 20,
                                                                               date: Date(),
                                                                               paid: false)],
                                                expensesType: [ExpenseType(name: "Transporte",
                                                                           expenses: [expenseDetail, expenseDetail])])
        
        expensesDetails = expenseModel.expenses + expenseModel.expenses + expenseModel.expenses + expenseModel.expenses
        expensesType = expenseModel.expensesType
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
