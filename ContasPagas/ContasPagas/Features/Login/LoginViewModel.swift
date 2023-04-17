//
//  LoginViewModel.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 17/04/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    func startNewSession() {
        KeysService.set(UUID().uuidString, for: .sessionID)
    }
}
