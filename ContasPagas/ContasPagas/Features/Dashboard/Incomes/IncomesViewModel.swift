//
//  IncomesViewModel.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 15/04/23.
//

import Foundation

class IncomesViewModel: ObservableObject {
    @Published var incomesDetails = [IncomeDetailsModel]()
    
    func fetchIncomes() {
        let incomeDetails = IncomeDetailsModel(name: "Salario", value: 1000, date: Date())
        incomesDetails = [incomeDetails, incomeDetails, incomeDetails]
    }
    
    func getTotalIncomesValue() -> Double {
        return incomesDetails.reduce(0.0) {
            $0 + $1.value
        }
    }
}
