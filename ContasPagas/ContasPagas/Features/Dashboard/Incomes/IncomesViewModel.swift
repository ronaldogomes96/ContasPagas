//
//  IncomesViewModel.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 15/04/23.
//

import Foundation

@MainActor
class IncomesViewModel: ObservableObject {
    @Published var incomesDetails = [IncomeDetailsModel]()
    @Published var hasError: Bool = false
    private var incomesUseCase: any FinancesUseCaseProtocol
    
    init(incomesUseCase: any FinancesUseCaseProtocol) {
        self.incomesUseCase = incomesUseCase
    }
    
    func fetchIncomes() async {
        do {
            guard let incomesDetails = try await incomesUseCase.readAll() as? [IncomeDetailsModel] else {
                hasError = true
                return
            }
            
            self.incomesDetails = incomesDetails
            hasError = false
        } catch {
            hasError = true
        }
    }
    
    func getTotalIncomesValue() -> Double {
        return incomesDetails.reduce(0.0) {
            $0 + $1.value
        }
    }
}
