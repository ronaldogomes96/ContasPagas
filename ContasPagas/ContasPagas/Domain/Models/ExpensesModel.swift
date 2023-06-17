//
//  FInancesTypeSections.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 14/04/23.
//

import Foundation

struct ExpensesModel: Codable {
    var expenses: [ExpenseDetailsModel]
    var expensesType: [ExpenseType]
}
