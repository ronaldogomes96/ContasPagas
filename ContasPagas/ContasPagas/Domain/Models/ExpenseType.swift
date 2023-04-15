//
//  FinanceryType.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 14/04/23.
//

import Foundation

struct ExpenseType: Codable, Identifiable {
    var id = UUID()
    let name: String
    let expenses: [ExpenseDetailsModel]
}
