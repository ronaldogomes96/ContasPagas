//
//  ExpensesTypeUseCase.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 04/06/23.
//

import Foundation

class ExpensesTypeUseCase: FinancesUseCaseProtocol {
    private let repository: RepositoryManager
    
    init(repository: RepositoryManager) {
        self.repository = repository
    }
    
    func add(finance: Codable) async throws {
        guard var user = repository.actualUserModel(),
              let finance = finance as? ExpenseType else {
            fatalError("User Model needs to be registered.")
        }
        
        user.expenseModel.expensesType.append(finance)
        
        try await repository.updateUser(user)
    }
    
    func readAll() async throws -> [Codable] {
        let userModel = try await repository.readUserModel()
        
        return userModel?.expenseModel.expensesType ?? []
    }
    
    func update(finance: Codable) async throws {
        guard var user = repository.actualUserModel(),
              let finance = finance as? ExpenseType else {
            fatalError("User Model needs to be registered.")
        }
        
        if let indexForRemove = findIndexInUserIncomes(for: user.expenseModel.expensesType,
                                                       and: finance.id) {
            user.expenseModel.expensesType.remove(at: indexForRemove)
            user.expenseModel.expensesType.append(finance)
            
            try await repository.updateUser(user)
        }
    }
    
    func delete(finance: Codable) async throws {
        guard var user = repository.actualUserModel(),
              let finance = finance as? ExpenseType else {
            fatalError("User Model needs to be registered.")
        }
        
        if let indexForRemove = findIndexInUserIncomes(for: user.expenseModel.expensesType,
                                                       and: finance.id) {
            user.expenseModel.expensesType.remove(at: indexForRemove)
            user.expenseModel.expensesType.append(finance)
            
            try await repository.deleteUser(user)
        }
    }
    
    private func findIndexInUserIncomes(for expensesType: [ExpenseType], and id: UUID) -> Int? {
        for (index, expenseType) in expensesType.enumerated() {
            if expenseType.id == id {
                return index
            }
        }
        
        return nil
    }
}
