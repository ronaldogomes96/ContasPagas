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
    
    func checkUserLoginState() {
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [weak self] user, error in
                self?.authenticate(user, with: error)
            }
        } else {
            userLoginState = .signedOut
        }
    }
    
    func signInUser() {
        guard let clientID = FirebaseApp.app()?.options.clientID ,
              let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            return
        }
        
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] result, error in
            self?.authenticate(result?.user, with: error)
        }
    }
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        
        do {
            try Auth.auth().signOut()
            
            userLoginState = .signedOut
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func authenticate(_ user: GIDGoogleUser?, with error: Error?) {
        guard error == nil,
              let accessToken = user?.accessToken,
              let idToken = user?.idToken?.tokenString else {
            userLoginState = .signedError
            return
        }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken.tokenString)
        
        Auth.auth().signIn(with: credential) { [weak self] (user, error) in
            if let error = error {
                self?.userLoginState = .signedError
                return
            }
            
            self?.userLoginState = .signedIn
        }
    }
}
