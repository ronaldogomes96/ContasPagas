//
//  FirebaseService.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 03/06/23.
//

import Foundation
import Firebase
import FirebaseFirestore

struct FirebaseService {
    private let database = Firestore.firestore().collection(UserModel.collectionName)
    
    func createUser(_ user: UserModel) async throws {
        try database.addDocument(from: user)
    }
    
    func readUser(with id: String) async throws -> [UserModel] {
        let query = try await database.whereField("userId", isEqualTo: id).getDocuments()
        
        let userModel = try query.documents.compactMap { userModel -> UserModel in
            return try userModel.data(as: UserModel.self)
        }
        
        return userModel
    }
    
    func updateUser(_ user: UserModel) async throws {
        guard let userId = user.id else {
            fatalError("User Model \(user.name) has no document ID.")
        }
        
        try database
            .document(userId)
            .setData(from: user,
                     merge: true)
    }
    
    func deleteUser(_ user: UserModel) async throws {
        guard let documentId = user.id else {
            fatalError("User Model \(user.name) has no document ID.")
        }
        
        try await database
            .document(documentId)
            .delete()
    }
}
