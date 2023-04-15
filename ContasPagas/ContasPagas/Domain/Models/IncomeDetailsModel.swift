//
//  IncomeDetailsModel.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 14/04/23.
//

import Foundation

struct IncomeDetailsModel: Codable, Identifiable {
    var id = UUID()
    let name: String
    let value: Double
    let date: Date
}
