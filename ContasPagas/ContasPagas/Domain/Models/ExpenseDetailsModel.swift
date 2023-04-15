//
//  ExpenseDetailsModel.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 14/04/23.
//

import Foundation

struct ExpenseDetailsModel: Codable, Identifiable {
    var id = UUID()
    let name: String
    let value: Double
    let date: Date
    let paid: Bool
}
