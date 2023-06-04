//
//  FInancesTypeSections.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 14/04/23.
//

import Foundation

struct ExpensesModel: Codable {
    let expenses: [ExpenseDetailsModel]
    let expensesType: [ExpenseType]
}
