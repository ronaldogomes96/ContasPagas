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
    
    func createNewUser(_ user: UserModel) async throws -> Void {
        try await firebaseService.createUser(user)
        
        userModel = user
    }
    
    func readUserModel() async throws -> UserModel? {
        let userModel = try await firebaseService.readUser()
        
        guard let userModel = userModel.first else {
            return nil
        }
        
        self.userModel = userModel
        return userModel
    }
    
    func updateUser(_ user: UserModel) async throws -> Void {
        try await firebaseService.updateUser(user)
        
        userModel = user
    }
    
    func deleteUser(_ user: UserModel) async throws -> Void {
        try await firebaseService.deleteUser(user)
        
        userModel = nil
    }
    
    func actualUserModel() -> UserModel? {
        return userModel
    }
}
