//
//  ExpenseUseCase.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 04/06/23.
//

import Foundation

class ExpenseUseCase: FinancesUseCaseProtocol {
    private let repository: RepositoryManager
    
    init(repository: RepositoryManager) {
        self.repository = repository
    }
    
    func add(finance: Codable) async throws {
        guard var user = repository.actualUserModel(),
              let finance = finance as? ExpenseDetailsModel else {
            fatalError("User Model needs to be registered.")
        }
        
        user.expenseModel.expenses.append(finance)
        
        try await repository.updateUser(user)
    }
    
    func readAll() async throws -> [Codable] {
        let userModel = try await repository.readUserModel()
        
        return userModel?.expenseModel.expenses ?? []
    }
    
    func update(finance: Codable) async throws {
        guard var user = repository.actualUserModel(),
              let finance = finance as? ExpenseDetailsModel else {
            fatalError("User Model needs to be registered.")
        }
        
        if let indexForRemove = findIndexInUserIncomes(for: user.expenseModel.expenses,
                                                       and: finance.id) {
            user.expenseModel.expenses.remove(at: indexForRemove)
            user.expenseModel.expenses.append(finance)
            
            try await repository.updateUser(user)
        }
    }
    
    func delete(finance: Codable) async throws {
        guard var user = repository.actualUserModel(),
              let finance = finance as? ExpenseDetailsModel else {
            fatalError("User Model needs to be registered.")
        }
        
        if let indexForRemove = findIndexInUserIncomes(for: user.expenseModel.expenses,
                                                       and: finance.id) {
            user.expenseModel.expenses.remove(at: indexForRemove)
            user.expenseModel.expenses.append(finance)
            
            try await repository.deleteUser(user)
        }
    }
    
    private func findIndexInUserIncomes(for expenses: [ExpenseDetailsModel], and id: UUID) -> Int? {
        for (index, expense) in expenses.enumerated() {
            if expense.id == id {
                return index
            }
        }
        
        return nil
    }
}
