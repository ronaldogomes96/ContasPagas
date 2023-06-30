//
//  LoginViewModel.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 29/06/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var userLoginState: LoginState = .loading
    private let authenticationFacade: AuthenticationFacadeProtocol
    
    init(authenticationFacade: AuthenticationFacadeProtocol) {
        self.authenticationFacade = authenticationFacade
    }
    
    func signIn() {
        authenticationFacade.signInUser { [weak self] loginState in
            self?.userLoginState = loginState
        }
    }
    
    func checkUserLoginState() {
        authenticationFacade.userLoginState { [weak self] loginState in
            self?.userLoginState = loginState
        }
    }
}
