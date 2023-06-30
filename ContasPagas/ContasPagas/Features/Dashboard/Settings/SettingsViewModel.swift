//
//  SettingsViewModel.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 29/06/23.
//

import Foundation

class SettingsViewModel: ObservableObject {
    
    private let authenticationFacade: AuthenticationFacadeProtocol
    
    init(authenticationFacade: AuthenticationFacadeProtocol) {
        self.authenticationFacade = authenticationFacade
    }
    
    func tryToSignOutWithSucess(completion: @escaping (Bool) -> Void) {
        authenticationFacade.signOut { loginState in
            completion(loginState == .signedOut)
        }
    }
}
