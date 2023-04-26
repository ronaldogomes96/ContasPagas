//
//  ContasPagasApp.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 19/03/23.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

@main
struct ContasPagasApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var viewModel = AuthenticationViewModel()
    
    init() {
        setupAuthentication()
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                switch viewModel.userLoginState {
                case .signedIn:
                    DashboardTabBarView()
                case .signedOut, .signedError:
                    LoginView(viewModel: viewModel)
                case .loading:
                    // MARK: - TODO: inserir o loading com imagem de logo
                    ProgressView()
                }
            }
            .onAppear {
                viewModel.checkUserLoginState()
            }
        }
    }
}

extension ContasPagasApp {
    private func setupAuthentication() {
        FirebaseApp.configure()
      }
}
