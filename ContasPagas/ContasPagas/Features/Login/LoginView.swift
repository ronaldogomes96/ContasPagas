//
//  ContentView.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 19/03/23.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(spacing: 58) {
            Image("Logo_levi")
                .frame(width: 170, height: 170)
                .background(Color.blue)
                .clipShape(Circle())
            
            Text(LocalizableStrings.appName.localized)
                .font(.largeTitle)

            Text(LocalizableStrings.loginMessageTitle.localized)
                .font(.title2)
                .multilineTextAlignment(.center)
            
            Button(action: {
                print("Navigate to login")
            }) {
                Text(LocalizableStrings.loginButtonTitle.localized)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: 42)
            .background(Color.black)
            .cornerRadius(10)
        }
        .padding(24)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
