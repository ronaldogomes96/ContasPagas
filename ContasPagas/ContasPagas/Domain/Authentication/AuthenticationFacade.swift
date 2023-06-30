//
//  AuthenticationFacade.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 26/06/23.
//

import Foundation
import Firebase
import GoogleSignIn

protocol AuthenticationFacadeProtocol {
    typealias LoginStateResponse = (LoginState) -> Void
    
    func userLoginState(completion: @escaping LoginStateResponse)
    func signInUser(completion: @escaping LoginStateResponse)
    func signOut(completion: @escaping LoginStateResponse)
}

class AuthenticationFacade: AuthenticationFacadeProtocol {
    
    typealias LoginStateResponse = (LoginState) -> Void
    private let googleInstance = GIDSignIn.sharedInstance
    private let firebaseAuth = Auth.auth()
    private let repository = RepositoryManager.shared
    
    func userLoginState(completion: @escaping LoginStateResponse) {
        googleInstance.hasPreviousSignIn() ? restorePreviousSignIn(completion: completion) : completion(.signedOut)
    }
    
    func signInUser(completion: @escaping LoginStateResponse) {
        guard let clientID = FirebaseApp.app()?.options.clientID ,
              let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            completion(.signedError)
            return
        }
        
        googleInstance.configuration = GIDConfiguration(clientID: clientID)
        
        googleInstance.signIn(withPresenting: rootViewController) { [weak self] result, error in
            self?.authenticate(result?.user,
                               with: error,
                               completion: completion)
        }
    }
    
    func signOut(completion: @escaping LoginStateResponse) {
        googleInstance.signOut()
        
        do {
            try Auth.auth().signOut()
            
            completion(.signedOut)
        } catch {
            completion(.signedError)
        }
    }
    
    private func restorePreviousSignIn(completion: @escaping LoginStateResponse) {
        googleInstance.restorePreviousSignIn { [weak self] user, error in
            guard let self else {
                completion(.signedError)
                return
            }
            
            if let currentUser = self.firebaseAuth.currentUser {
                Task {
                    await self.readCurrentUserIfPossible(currentUser, completion: completion)
                }
            }
            
            completion(.signedOut)
        }
    }
    
    private func readCurrentUserIfPossible(_ currentUser: User,
                                           completion: @escaping LoginStateResponse) async {
        do {
            let _ = try await self.repository.readUserModel(with: currentUser.uid)
            completion(.signedIn)
        }
        catch {
            completion(.signedOut)
        }
    }
    
    private func authenticate(_ user: GIDGoogleUser?,
                              with error: Error?,
                              completion: @escaping LoginStateResponse) {
        guard error == nil,
              let accessToken = user?.accessToken,
              let idToken = user?.idToken?.tokenString else {
            completion(.signedError)
            return
        }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                       accessToken: accessToken.tokenString)
        
        Auth.auth().signIn(with: credential) { [weak self] (user, error) in
            
            guard let self = self,
                  error == nil,
                  let user = user?.user else {
                completion(.signedError)
                return
            }
            
            Task {
                await self.createNewUserModel(with: user,
                                           completion: completion)
            }
            
        }
    }
    
    private func createNewUserModel(with user: User,
                                    completion: LoginStateResponse) async {
        do {
            try await self.repository.createNewUser(UserModel(userId: user.uid,
                                                              name: user.displayName ?? "",
                                                              email: user.email ?? "",
                                                              expenseModel: ExpensesModel(expenses: [],
                                                                                          expensesType: []),
                                                              incomes: []))
            
            completion(.signedIn)
        } catch {
            completion(.signedError)
        }
    }
}
