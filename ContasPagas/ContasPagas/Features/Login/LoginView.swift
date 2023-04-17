//
//  ContentView.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 19/03/23.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 58) {
                Text(LocalizableStrings.appName.localized)
                    .font(.largeTitle)

                Text(LocalizableStrings.loginMessageTitle.localized)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                
                NavigationLink {
                    DashboardTabBarView()
                        .onAppear {
                            viewModel.startNewSession()
                        }
                } label: {
                    Text(LocalizableStrings.loginButtonTitle.localized)
                        .bold()
                        .padding(4)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(24)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }
}
