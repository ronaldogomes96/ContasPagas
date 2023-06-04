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
    
    func createUser(_ user: UserModel) async throws -> Void {
        try database.addDocument(from: user)
    }
    
    func readUser() async throws -> [UserModel] {
        let query = try await database.getDocuments()
        
        let userModel = try query.documents.compactMap { userModel -> UserModel in
            return try userModel.data(as: UserModel.self)
        }
        
        return userModel
    }
    
    func updateUser(_ user: UserModel) async throws -> Void {
        guard let documentId = user.id else {
            fatalError("User Model \(user.name) has no document ID.")
        }
        
        try database
            .document(documentId)
            .setData(from: user,
                     merge: true)
    }
    
    func deleteUser(_ user: UserModel) async throws -> Void {
        guard let documentId = user.id else {
            fatalError("User Model \(user.name) has no document ID.")
        }
        
        try await database
            .document(documentId)
            .delete()
    }
}
