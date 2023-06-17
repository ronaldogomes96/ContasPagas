//
//  RepositoryManager.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 03/06/23.
//

import Foundation

// deve tratar tanto firebase quanto core data

class RepositoryManager {
    private var userModel: UserModel?
    static let shared = RepositoryManager()
    private let firebaseService = FirebaseService()
    
    func createNewUser(_ user: UserModel) async throws {
        try await firebaseService.createUser(user)
        
        RepositoryManager.shared.userModel = user
    }
    
    func readUserModel(with id: String? = RepositoryManager.shared.userModel?.userId) async throws -> UserModel? {
        guard let id else {
            fatalError("User Model has no document ID.")
        }
        
        let userModel = try await firebaseService.readUser(with: id)
        
        guard let userModel = userModel.first else {
            return nil
        }
        
        RepositoryManager.shared.userModel = userModel
        return userModel
    }
    
    func updateUser(_ user: UserModel) async throws {
        try await firebaseService.updateUser(user)
        
        RepositoryManager.shared.userModel = user
    }
    
    func deleteUser(_ user: UserModel) async throws {
        try await firebaseService.deleteUser(user)
        
        RepositoryManager.shared.userModel = nil
    }
    
    func actualUserModel() -> UserModel? {
        return RepositoryManager.shared.userModel
    }
}
