//
//  ContasPagasApp.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 19/03/23.
//

import SwiftUI

@main
struct ContasPagasApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if KeysService.get(.sessionID) == nil {
                    LoginView(viewModel: LoginViewModel())
                } else {
                    DashboardTabBarView()
                }
            }
        }
    }
}
