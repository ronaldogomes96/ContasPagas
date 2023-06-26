//
//  AuthenticationViewModel.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 26/04/23.
//

import Firebase
import GoogleSignIn

class AuthenticationViewModel: ObservableObject {
    
    enum LoginState {
        case signedIn
        case signedOut
        case signedError
        case loading
    }
    
    @Published var userLoginState: LoginState = .loading
    private let googleInstance = GIDSignIn.sharedInstance
    private let firebaseAuth = Auth.auth()
    private let repository = RepositoryManager.shared
    
    func checkUserLoginState() {
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [weak self] user, error in
                guard let self else {
                    return
                }
                
                if let currentUser = firebaseAuth.currentUser {
                    Task {
                        do {
                            let _ = try await self.repository.readUserModel(with: currentUser.uid)
                            self.userLoginState = .signedIn
                        } catch {
                            self.userLoginState = .signedOut
                        }
                    }
                } else {
                    userLoginState = .signedOut
                }
            }
        } else {
            userLoginState = .signedOut
        }
    }
    
    func signInUser() {
        guard let clientID = FirebaseApp.app()?.options.clientID ,
              let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            userLoginState = .signedError
            return
        }
        
        googleInstance.configuration = GIDConfiguration(clientID: clientID)
        
        googleInstance.signIn(withPresenting: rootViewController) { [weak self] result, error in
            self?.authenticate(result?.user,
                               with: error)
        }
    }
    
    func signOut() {
        googleInstance.signOut()
        
        do {
            try Auth.auth().signOut()
            
            userLoginState = .signedOut
        } catch {
            print(error.localizedDescription)
            userLoginState = .signedError
        }
    }
    
    private func authenticate(_ user: GIDGoogleUser?,
                              with error: Error?) {
        guard error == nil,
              let accessToken = user?.accessToken,
              let idToken = user?.idToken?.tokenString else {
            userLoginState = .signedError
            return
        }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                       accessToken: accessToken.tokenString)
        
        Auth.auth().signIn(with: credential) { [weak self] (user, error) in
            
            guard let self = self,
                  error == nil,
                  let user = user?.user else {
                self?.userLoginState = .signedError
                return
            }
            
            Task {
                await self.createUserModel(with: user)
            }
            
        }
    }
    
    private func createUserModel(with user: User) async {
        do {
            try await self.repository.createNewUser(UserModel(userId: user.uid, name: user.displayName ?? "",
                                                              email: user.email ?? "",
                                                              expenseModel: ExpensesModel(expenses: [],
                                                                                          expensesType: []),
                                                              incomes: []))
            
            self.userLoginState = .signedIn
        } catch {
            self.userLoginState = .signedError
            return
        }
    }
}
