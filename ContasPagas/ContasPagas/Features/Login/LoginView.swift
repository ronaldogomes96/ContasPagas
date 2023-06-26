//
//  ContentView.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 19/03/23.
//

import SwiftUI
import AuthenticationServices
import GoogleSignInSwift

struct LoginView: View {
    @StateObject private var viewModel: AuthenticationViewModel
    
    init(viewModel: AuthenticationViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 58) {
                Text(LocalizableStrings.appName.localized)
                    .font(.largeTitle)

                Text(LocalizableStrings.loginMessageTitle.localized)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                
                GoogleSignInButton(style: .wide) {
                    viewModel.signInUser()
                }
            }
            .padding(24)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: AuthenticationViewModel())
    }
}
