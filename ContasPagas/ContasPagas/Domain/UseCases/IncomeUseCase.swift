//
//  IncomeUseCase.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 04/06/23.
//

import Foundation

protocol FinancesUseCaseProtocol {
    func add(finance: Codable) async throws
    func readAll() async throws -> [Codable]
    func update(finance: Codable) async throws
    func delete(finance: Codable) async throws
}

class IncomeUseCase: FinancesUseCaseProtocol {
    private let repository: RepositoryManager
    
    init(repository: RepositoryManager) {
        self.repository = repository
    }
    
    func add(finance: Codable) async throws {
        guard var user = repository.actualUserModel(),
              let finance = finance as? IncomeDetailsModel else {
            fatalError("User Model needs to be registered.")
        }
        
        user.incomes.append(finance)
        
        try await repository.updateUser(user)
    }
    
    func readAll() async throws -> [Codable] {
        let userModel = try await repository.readUserModel()
        
        return userModel?.incomes ?? []
    }
    
    func update(finance: Codable) async throws {
        guard var user = repository.actualUserModel(),
              let finance = finance as? IncomeDetailsModel else {
            fatalError("User Model needs to be registered.")
        }
        
        if let indexForRemove = findIndexInUserIncomes(for: user.incomes,
                                                       and: finance.id) {
            user.incomes.remove(at: indexForRemove)
            user.incomes.append(finance)
            
            try await repository.updateUser(user)
        }
    }
    
    func delete(finance: Codable) async throws {
        guard var user = repository.actualUserModel(),
              let finance = finance as? IncomeDetailsModel else {
            fatalError("User Model needs to be registered.")
        }
        
        if let indexForRemove = findIndexInUserIncomes(for: user.incomes,
                                                       and: finance.id) {
            user.incomes.remove(at: indexForRemove)
            user.incomes.append(finance)
            
            try await repository.deleteUser(user)
        }
    }
    
    private func findIndexInUserIncomes(for incomes: [IncomeDetailsModel], and id: UUID) -> Int? {
        for (index, income) in incomes.enumerated() {
            if income.id == id {
                return index
            }
        }
        
        return nil
    }
}
